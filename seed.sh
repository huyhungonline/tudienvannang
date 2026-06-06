#!/bin/bash
# Seed sample data for public_searches table
# Usage: wsl -e bash -c "cd /mnt/c/source/dic && bash seed.sh"

echo "========== SEEDING public_searches =========="

docker exec -i dic-postgres-1 psql -U postgres -d english_word_splitter <<'SQL'
INSERT INTO public_searches (input_text, target_language) VALUES
('Oil has been moving within a broad trading range, with key support levels formed near prior consolidation zones and resistance near recent highs.', 'ja'),
('The Federal Reserve held interest rates steady, signaling patience amid mixed economic data.', 'ja'),
('Gold prices surged to a new all-time high as investors sought safe-haven assets amid geopolitical uncertainty.', 'ja'),
('The unemployment rate fell to 3.8 percent, marking the lowest level in two decades.', 'vi'),
('Treasury yields climbed after stronger-than-expected retail sales data raised concerns about persistent inflation.', 'ja'),
('Central banks across Asia have been accumulating gold reserves at an unprecedented pace this year.', 'zh'),
('The dollar index weakened as markets priced in a potential rate cut in the coming quarter.', 'ja'),
('Silver outperformed gold this week, driven by industrial demand from the solar energy sector.', 'vi'),
('Consumer confidence improved modestly in May, supported by a resilient labor market.', 'ja'),
('European equities rallied on expectations of fiscal stimulus measures from Germany and France.', 'ja')
ON CONFLICT DO NOTHING;
SQL

if [ $? -eq 0 ]; then
  echo "✅ Seeding completed successfully"
else
  echo "❌ Seeding failed"
fi

echo ""
echo "========== VERIFY =========="
docker exec -i dic-postgres-1 psql -U postgres -d english_word_splitter -c "SELECT count(*) as total FROM public_searches;"
