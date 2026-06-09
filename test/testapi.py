"""Test API: tách từ + lưu history
Usage: python testapi.py
"""
import requests
import json

BASE = "http://localhost:4000/api"

# Test credentials - đổi nếu cần
EMAIL = "test@example.com"
PASSWORD = "Test1234"


def test_split_en_ja():
    """Test tách từ English → Japanese"""
    print("=== [1] Split EN → JA ===")
    r = requests.post(f"{BASE}/words/split", json={
        "text": "The economy is recovering from the pandemic",
        "sourceLanguage": "en",
        "targetLanguage": "ja"
    }, timeout=30)
    print(f"Status: {r.status_code}")
    if r.status_code == 200:
        data = r.json()
        print(f"Words: {len(data['words'])}")
        for w in data['words'][:3]:
            print(f"  {w['word']} | {w['ipa']} | {w['translation']}")
        print(f"Sentence: {data['sentenceTranslation']}")
    else:
        print(f"Error: {r.text}")
    print()
    return r.json() if r.status_code == 200 else None


def test_split_ja_vi():
    """Test tách từ Japanese → Vietnamese"""
    print("=== [2] Split JA → VI ===")
    r = requests.post(f"{BASE}/words/split", json={
        "text": "経済は回復している",
        "sourceLanguage": "ja",
        "targetLanguage": "vi"
    }, timeout=30)
    print(f"Status: {r.status_code}")
    if r.status_code == 200:
        data = r.json()
        print(f"Words: {len(data['words'])}")
        for w in data['words']:
            print(f"  {w['word']} | {w['ipa']} | {w['translation']}")
        print(f"Sentence: {data['sentenceTranslation']}")
    else:
        print(f"Error: {r.text}")
    print()
    return r.json() if r.status_code == 200 else None


def register_user():
    """Register test user"""
    print("=== [3] Register user ===")
    r = requests.post(f"{BASE}/auth/register", json={
        "email": EMAIL,
        "password": PASSWORD,
        "captchaToken": "test"
    }, timeout=10)
    if r.status_code == 201:
        print(f"Registered: {EMAIL}")
        return r.json().get("token")
    elif r.status_code == 400:
        print(f"Already exists, trying login...")
        return None
    else:
        print(f"Register failed: {r.status_code} {r.text}")
        return None


def login_user():
    """Login test user"""
    print("=== [4] Login ===")
    r = requests.post(f"{BASE}/auth/login", json={
        "email": EMAIL,
        "password": PASSWORD,
        "captchaToken": "test"
    }, timeout=10)
    if r.status_code == 200:
        token = r.json().get("token")
        print(f"Login OK, token: {token[:20]}...")
        return token
    else:
        print(f"Login failed: {r.status_code} {r.text}")
        return None


def test_save_history(token, split_result):
    """Save to history"""
    print("=== [5] Save History ===")
    if not token:
        print("No token, skipping")
        return
    if not split_result:
        print("No split result, skipping")
        return

    r = requests.post(f"{BASE}/history", json={
        "inputText": "The economy is recovering from the pandemic",
        "words": split_result["words"],
        "targetLanguage": "ja",
        "sentenceTranslation": split_result["sentenceTranslation"]
    }, headers={"Authorization": f"Bearer {token}"}, timeout=10)
    print(f"Status: {r.status_code}")
    if r.status_code == 201:
        print("History saved!")
        print(f"Record: {json.dumps(r.json(), indent=2, ensure_ascii=False)[:200]}")
    else:
        print(f"Error: {r.text}")
    print()


def test_list_history(token):
    """List history"""
    print("=== [6] List History ===")
    if not token:
        print("No token, skipping")
        return

    r = requests.get(f"{BASE}/history", headers={
        "Authorization": f"Bearer {token}"
    }, timeout=10)
    print(f"Status: {r.status_code}")
    if r.status_code == 200:
        records = r.json().get("records", [])
        print(f"Total records: {len(records)}")
        for rec in records[:3]:
            print(f"  - {rec.get('inputText', '')[:50]}... ({rec.get('targetLanguage')})")
    else:
        print(f"Error: {r.text}")
    print()


if __name__ == "__main__":
    # Test split
    split_result = test_split_en_ja()
    test_split_ja_vi()

    # Auth + History
    token = register_user()
    if not token:
        token = login_user()

    if token:
        test_save_history(token, split_result)
        test_list_history(token)
    else:
        print("\n❌ Could not authenticate. History tests skipped.")

    print("=== DONE ===")
