import fugashi
tagger = fugashi.Tagger()
for word in tagger('経済が回復してしまった'):
    print(f'{word.surface} -> {word.feature}')
