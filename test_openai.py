"""Test Azure OpenAI API with gpt-5.2-chat deployment."""
import os
import requests
from dotenv import load_dotenv

load_dotenv()

ENDPOINT = os.getenv("AZURE_OPENAI_ENDPOINT", "https://aoai-digidev-mcp-platform-eus2-9999.openai.azure.com/openai/responses")
API_VERSION = os.getenv("AZURE_OPENAI_API_VERSION", "2025-04-01-preview")
API_KEY = os.getenv("AZURE_OPENAI_API_KEY", "")

if not API_KEY:
    print("Error: AZURE_OPENAI_API_KEY not set in .env")
    exit(1)

url = f"{ENDPOINT}?api-version={API_VERSION}"

headers = {
    "Content-Type": "application/json",
    "api-key": API_KEY,
}

payload = {
    "model": "gpt-5.2-chat",
    "input": "Say hello in Japanese",
}

print(f"Testing: {url}")
print(f"Model: gpt-5.2-chat")
print("---")

try:
    response = requests.post(url, headers=headers, json=payload, timeout=30)
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text[:500]}")
except Exception as e:
    print(f"Error: {e}")
