"""Test Azure OpenAI API - Macro News (tin vĩ mô)
Usage: python3 test/openai.py [gold|oil|silver|us_treasury|central_banks]
"""
import os
import sys
import requests
from dotenv import load_dotenv

load_dotenv()

ENDPOINT = os.getenv("AZURE_OPENAI_ENDPOINT", "https://aoai-digidev-mcp-platform-eus2-9999.openai.azure.com/openai/responses")
API_VERSION = os.getenv("AZURE_OPENAI_API_VERSION", "2025-03-01-preview")
API_KEY = os.getenv("AZURE_OPENAI_API_KEY", "")
MODEL = os.getenv("AZURE_OPENAI_MODEL", "gpt-5.2-chat")

if not API_KEY:
    print("Error: AZURE_OPENAI_API_KEY not set in .env")
    sys.exit(1)

url = f"{ENDPOINT}?api-version={API_VERSION}"

headers = {
    "Content-Type": "application/json",
    "api-key": API_KEY,
}

PROMPTS = {
    "gold": (
        "Provide a brief macro-economic analysis of gold prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how gold movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "silver": (
        "Provide a brief macro-economic analysis of silver prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how silver movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "oil": (
        "Provide a brief macro-economic analysis of crude oil prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how oil price movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "us_treasury": (
        "Provide a brief macro-economic analysis of US Treasury yields. Include: "
        "1) Current yield trend summary (2Y, 10Y, 30Y), "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how Treasury yield movements affect stocks, currencies, gold, and credit markets). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "central_banks": (
        "Provide a brief macro-economic analysis of major central bank policies (Fed, ECB, BOJ, BOE). Include: "
        "1) Current policy stance summary, "
        "2) Recent decisions and forward guidance analysis, "
        "3) Cross-market impact (how central bank policies affect stocks, bonds, currencies, and commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
}

# Chọn category
category = sys.argv[1] if len(sys.argv) > 1 else "gold"
if category not in PROMPTS:
    print(f"Invalid category. Choose: {', '.join(PROMPTS.keys())}")
    sys.exit(1)

prompt = PROMPTS[category]
payload = {"model": MODEL, "input": prompt}

print(f"=== Macro News: {category.upper()} ===")
print(f"Endpoint: {url}")
print(f"Model: {MODEL}")
print("---")
print()

try:
    response = requests.post(url, headers=headers, json=payload, timeout=60)
    print(f"Status: {response.status_code}")
    print()

    if response.status_code == 200:
        data = response.json()
        # Parse Azure OpenAI Responses API format
        if "output" in data:
            for item in data["output"]:
                if item.get("type") == "message":
                    for content in item.get("content", []):
                        if content.get("type") == "output_text":
                            text = content["text"]
                            print(text)
                            print()
                            print(f"--- {len(text)} chars ---")
        elif "choices" in data:
            text = data["choices"][0]["message"]["content"]
            print(text)
            print(f"--- {len(text)} chars ---")
        else:
            print(f"Unexpected format: {str(data)[:300]}")
    else:
        print(f"Error: {response.text[:500]}")

except Exception as e:
    print(f"Error: {e}")
