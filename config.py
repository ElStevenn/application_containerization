import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text

BASE_DIR = os.path.abspath(os.path.dirname(__file__))

DEBUG = os.getenv('DEBUG_MODE',False)
SECRET_KEY = os.getenv('SECRET_KEY')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')

CSRF_ENABLED = True
CSRF_SESSION_KEY = SECRET_KEY

SQLALCHEMY_TRACK_MODIFICATIONS = False

engine = create_engine('mysql://' + DB_USER + ':' + DB_PASS + '@182.18.0.2/' + DB_NAME)
SQLALCHEMY_DATABASE_URI = 'mysql://' + DB_USER + ':' + DB_PASS + '@182.18.0.2/' + DB_NAME

Session = sessionmaker(bind=engine)

def get_all_db_names():
    """Sample function to show whether the function works or nit"""
    with engine.connect() as connection:
        result = connection.execute(text("SHOW DATABASES"))
        databases = [row[0] for row in result]
    return databases


if __name__ == '__main__':
    print(get_all_db_names())