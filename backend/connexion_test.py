"""Vérifie que Python arrive à se connecter à la base."""
from sqlalchemy import text

from api.db import engine

with engine.connect() as conn:
    print("Connectée en tant que :", conn.execute(text("SELECT current_user")).scalar())
    print("Tables AOMI           :", conn.execute(text(
        "SELECT count(*) FROM pg_tables WHERE schemaname = 'public'")).scalar())
print("Connexion OK")