import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker


load_dotenv()
url = os.getenv("URL_BASE")

if url is None:
    raise RuntimeError("URL_BASE introuvable : vérifiez le fichier .env à la racine du projet")
DATABASE_URL = url.replace("postgresql://", "postgresql+psycopg://", 1)
engine = create_engine(DATABASE_URL, pool_pre_ping=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try :
        yield db 

    finally:
        db.close()