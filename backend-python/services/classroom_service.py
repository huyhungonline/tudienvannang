import uuid

import db

CLASSROOM_ID = 1


async def get_classroom_state() -> dict:
    """Returns the full classroom state: teacher, all seats with search_count."""
    classroom = await db.query_one(
        "SELECT id, name, teacher_id FROM classrooms WHERE id = $1",
        CLASSROOM_ID,
    )
    if not classroom:
        return {"id": CLASSROOM_ID, "name": "Main Classroom", "teacher": None, "seats": [], "total_students": 0, "top_students": [], "questions": []}

    # Default teacher is admin if no teacher assigned
    teacher_id = classroom["teacher_id"]
    if not teacher_id:
        admin_row = await db.query_one(
            "SELECT id FROM users WHERE is_admin = true ORDER BY created_at ASC LIMIT 1"
        )
        if admin_row:
            teacher_id = admin_row["id"]

    teacher = None
    if teacher_id:
        teacher_row = await db.query_one(
            "SELECT u.id, u.email, COALESCE(usc.search_count, 0) AS search_count "
            "FROM users u "
            "LEFT JOIN user_search_counts usc ON usc.user_id = u.id "
            "WHERE u.id = $1",
            teacher_id,
        )
        if teacher_row:
            teacher = {
                "id": str(teacher_row["id"]),
                "email": teacher_row["email"],
                "search_count": teacher_row["search_count"],
            }

    seat_rows = await db.query(
        "SELECT cs.row_number, cs.seat_number, cs.user_id, u.email, "
        "COALESCE(usc.search_count, 0) AS search_count "
        "FROM classroom_seats cs "
        "JOIN users u ON u.id = cs.user_id "
        "LEFT JOIN user_search_counts usc ON usc.user_id = cs.user_id "
        "WHERE cs.classroom_id = $1 "
        "ORDER BY cs.row_number, cs.seat_number",
        CLASSROOM_ID,
    )

    seats = [
        {
            "row_number": row["row_number"],
            "seat_number": row["seat_number"],
            "user_id": str(row["user_id"]),
            "email": row["email"],
            "search_count": row["search_count"],
        }
        for row in seat_rows
    ]

    return {
        "id": classroom["id"],
        "name": classroom["name"],
        "teacher": teacher,
        "seats": seats,
        "total_students": len(seats),
        "top_students": await _get_top_students(),
        "questions": await _get_active_questions(),
    }


async def _get_active_questions() -> list[str]:
    """Returns active classroom questions."""
    rows = await db.query(
        "SELECT question FROM classroom_questions WHERE is_active = true ORDER BY created_at DESC"
    )
    return [r["question"] for r in rows]


async def _get_top_students(limit: int = 5) -> list[dict]:
    """Returns top N students by search count (updated today)."""
    rows = await db.query(
        "SELECT u.email, usc.search_count "
        "FROM user_search_counts usc "
        "JOIN users u ON u.id = usc.user_id "
        "WHERE usc.updated_at >= CURRENT_DATE "
        "ORDER BY usc.search_count DESC "
        "LIMIT $1",
        limit,
    )
    return [{"email": r["email"], "search_count": r["search_count"]} for r in rows]


async def join_seat(user_id: str, row_number: int, seat_number: int) -> dict:
    """Validates and inserts a user into a specific seat."""
    user_uuid = uuid.UUID(user_id)

    # Validate seat position
    if not (1 <= row_number <= 10 and 1 <= seat_number <= 10):
        raise ValueError("Invalid seat position")

    # Check if user already seated
    existing = await db.query_one(
        "SELECT id FROM classroom_seats WHERE classroom_id = $1 AND user_id = $2",
        CLASSROOM_ID, user_uuid,
    )
    if existing:
        raise ValueError("User already seated")

    # Check if seat is taken
    taken = await db.query_one(
        "SELECT id FROM classroom_seats WHERE classroom_id = $1 AND row_number = $2 AND seat_number = $3",
        CLASSROOM_ID, row_number, seat_number,
    )
    if taken:
        raise ValueError("Seat is already taken")

    # Check if classroom is full (100 seats)
    count_row = await db.query_one(
        "SELECT COUNT(*) AS cnt FROM classroom_seats WHERE classroom_id = $1",
        CLASSROOM_ID,
    )
    if count_row and count_row["cnt"] >= 100:
        raise ValueError("Classroom is full")

    # Insert seat assignment
    await db.execute(
        "INSERT INTO classroom_seats (classroom_id, user_id, row_number, seat_number) "
        "VALUES ($1, $2, $3, $4)",
        CLASSROOM_ID, user_uuid, row_number, seat_number,
    )

    return {"message": "Joined successfully", "row_number": row_number, "seat_number": seat_number}


async def leave_classroom(user_id: str) -> dict:
    """Removes user from seat or teacher position."""
    user_uuid = uuid.UUID(user_id)

    # Check if user is a seated student
    seat = await db.query_one(
        "SELECT id FROM classroom_seats WHERE classroom_id = $1 AND user_id = $2",
        CLASSROOM_ID, user_uuid,
    )

    # Check if user is the teacher
    classroom = await db.query_one(
        "SELECT teacher_id FROM classrooms WHERE id = $1",
        CLASSROOM_ID,
    )
    is_teacher = classroom and classroom["teacher_id"] == user_uuid

    if not seat and not is_teacher:
        raise ValueError("User is not in the classroom")

    # Remove from seat if seated
    if seat:
        await db.execute(
            "DELETE FROM classroom_seats WHERE classroom_id = $1 AND user_id = $2",
            CLASSROOM_ID, user_uuid,
        )

    # Remove from teacher if teacher
    if is_teacher:
        await db.execute(
            "UPDATE classrooms SET teacher_id = NULL WHERE id = $1",
            CLASSROOM_ID,
        )

    return {"message": "Left classroom"}


async def become_teacher(user_id: str) -> dict:
    """Sets user as teacher, removes from student seat if needed."""
    user_uuid = uuid.UUID(user_id)

    # Check if another teacher already exists
    classroom = await db.query_one(
        "SELECT teacher_id FROM classrooms WHERE id = $1",
        CLASSROOM_ID,
    )
    if classroom and classroom["teacher_id"] is not None and classroom["teacher_id"] != user_uuid:
        raise ValueError("Another user is already the teacher")

    # Remove from student seat if currently seated
    await db.execute(
        "DELETE FROM classroom_seats WHERE classroom_id = $1 AND user_id = $2",
        CLASSROOM_ID, user_uuid,
    )

    # Set as teacher
    await db.execute(
        "UPDATE classrooms SET teacher_id = $1 WHERE id = $2",
        user_uuid, CLASSROOM_ID,
    )

    return {"message": "You are now the teacher"}


async def increment_search_count(user_id: str) -> None:
    """Upsert search_count +1 for user."""
    user_uuid = uuid.UUID(user_id)
    await db.execute(
        "INSERT INTO user_search_counts (user_id, search_count, updated_at) "
        "VALUES ($1, 1, NOW()) "
        "ON CONFLICT (user_id) DO UPDATE SET search_count = user_search_counts.search_count + 1, updated_at = NOW()",
        user_uuid,
    )


async def get_user_search_count(user_id: str) -> int:
    """Returns current search count for user."""
    user_uuid = uuid.UUID(user_id)
    row = await db.query_one(
        "SELECT search_count FROM user_search_counts WHERE user_id = $1",
        user_uuid,
    )
    return row["search_count"] if row else 0
