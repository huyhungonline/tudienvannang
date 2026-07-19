import ast
with open("backend-python/routes/auth.py") as f:
    ast.parse(f.read())
print("auth.py syntax OK")
