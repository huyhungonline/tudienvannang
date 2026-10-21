#!/bin/bash
# Query the public AWS Pricing API for S3 Standard storage price
# in Sydney, Singapore, and Tokyo. Read-only, no credentials needed.

declare -A REGIONS=(
  ["ap-southeast-2"]="Asia Pacific (Sydney)"
  ["ap-southeast-1"]="Asia Pacific (Singapore)"
  ["ap-northeast-1"]="Asia Pacific (Tokyo)"
  ["us-east-1"]="US East (N. Virginia)"
)

URL="https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonS3/current/index.json"

echo "Downloading AWS S3 price list (this is a large file)..."
curl -s "$URL" -o /tmp/s3price.json || { echo "download failed"; exit 1; }
ls -lh /tmp/s3price.json | awk '{print "downloaded:", $5}'
echo ""

for region in "${!REGIONS[@]}"; do
    name="${REGIONS[$region]}"
    price=$(python3 - "$region" <<'PY'
import json, sys
region = sys.argv[1]
with open('/tmp/s3price.json') as f:
    data = json.load(f)

# Find Standard storage SKUs for the region's location name
loc_map = {
    'ap-southeast-2': 'Asia Pacific (Sydney)',
    'ap-southeast-1': 'Asia Pacific (Singapore)',
    'ap-northeast-1': 'Asia Pacific (Tokyo)',
    'us-east-1': 'US East (N. Virginia)',
}
loc = loc_map[region]

skus = []
for sku, p in data['products'].items():
    a = p.get('attributes', {})
    if (a.get('location') == loc
            and a.get('storageClass') == 'General Purpose'
            and a.get('volumeType') == 'Standard'
            and p.get('productFamily') == 'Storage'):
        skus.append(sku)

prices = []
for sku in skus:
    for term in data['terms']['OnDemand'].get(sku, {}).values():
        for dim in term['priceDimensions'].values():
            usd = float(dim['pricePerUnit']['USD'])
            if usd > 0:
                prices.append((usd, dim.get('beginRange'), dim.get('description', '')))
if prices:
    prices.sort()
    # First tier (lowest range) is what small buckets pay
    base = [p for p in prices if p[1] == '0']
    print(f"{(base[0][0] if base else prices[0][0]):.5f}")
else:
    print("n/a")
PY
)
    echo "$price|$region|$name"
done | sort -t'|' -k1 -n | while IFS='|' read -r price region name; do
    printf '%-18s %-28s $%s /GB/month\n' "$region" "$name" "$price"
done

rm -f /tmp/s3price.json
