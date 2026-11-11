"""Load test: N learners start an IT Passport mock exam and submit it at once.

Usage (local backend only by default):
    LOAD_TOKEN=<vip jwt> python3 test/load_mock_exam.py [--users 100] [--base http://localhost:4000]

LOAD_TOKEN is read from the environment so no credential lands in shell history
or this file. One VIP token is shared by all simulated users; the server-side
cost per request is identical. Pass --allow-remote to target a non-local host.
"""
import argparse
import json
import os
import statistics
import sys
import time
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import urlparse


def call(base, token, method, path, body=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(
        base + path, data=data, method=method,
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
    )
    t0 = time.perf_counter()
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            payload = json.loads(r.read())
            status = r.status
    except urllib.error.HTTPError as e:
        payload, status = None, e.code
    except Exception:
        payload, status = None, 0
    return status, time.perf_counter() - t0, payload


def one_learner(args):
    base, token, code = args
    s1, t_start, paper = call(base, token, "GET", f"/api/certificates/{code}/mock-exam/start")
    if s1 != 200 or not paper:
        return {"ok": False, "start": t_start, "submit": 0, "ids": [], "stage": f"start:{s1}"}
    ids = [q["id"] for q in paper["questions"]]
    answers = [{"questionId": q["id"], "selectedLabel": (q.get("choices") or [""])[0]}
               for q in paper["questions"]]
    s2, t_submit, _ = call(base, token, "POST", f"/api/certificates/{code}/mock-exam/submit",
                           {"answers": answers, "durationSeconds": 1800})
    return {"ok": s2 == 200, "start": t_start, "submit": t_submit, "ids": ids,
            "stage": "done" if s2 == 200 else f"submit:{s2}"}


def pct(values, p):
    values = sorted(values)
    return values[min(len(values) - 1, int(len(values) * p))] if values else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--users", type=int, default=100)
    ap.add_argument("--base", default="http://localhost:4000")
    ap.add_argument("--code", default="itpp")
    ap.add_argument("--allow-remote", action="store_true")
    a = ap.parse_args()

    token = os.environ.get("LOAD_TOKEN")
    if not token:
        sys.exit("Set LOAD_TOKEN to a VIP/admin JWT")
    host = urlparse(a.base).hostname
    if host not in ("localhost", "127.0.0.1") and not a.allow_remote:
        sys.exit(f"Refusing to load-test {host}; pass --allow-remote if intended")

    t0 = time.perf_counter()
    with ThreadPoolExecutor(max_workers=a.users) as pool:
        results = list(pool.map(one_learner, [(a.base, token, a.code)] * a.users))
    wall = time.perf_counter() - t0

    ok = [r for r in results if r["ok"]]
    print(f"users={a.users} ok={len(ok)} failed={a.users - len(ok)} wall={wall:.1f}s")
    for stage in sorted({r['stage'] for r in results if not r['ok']}):
        print(f"  failure {stage}: {sum(1 for r in results if r['stage'] == stage)}")
    for name in ("start", "submit"):
        v = [r[name] for r in ok]
        if v:
            print(f"{name:6s} avg={statistics.mean(v):.2f}s p50={pct(v, .5):.2f}s "
                  f"p95={pct(v, .95):.2f}s max={max(v):.2f}s")
    papers = {tuple(sorted(r["ids"])) for r in ok}
    print(f"distinct papers: {len(papers)}/{len(ok)}")
    sys.exit(0 if len(ok) == a.users else 1)


if __name__ == "__main__":
    main()
