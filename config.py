import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

BASE_DIR = os.path.abspath(os.path.dirname(__file__))

DEBUG = os.getenv('DEBUG_MODE',False)
SECRET_KEY = os.getenv('SECRET_KEY')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')

CSRF_ENABLED = True
CSRF_SESSION_KEY = SECRET_KEY

SQLALCHEMY_TRACK_MODIFICATIONS = False

engine = create_engine('mysql://' + DB_USER + ':' + DB_PASS + '@localhost/' + DB_NAME)
SQLALCHEMY_DATABASE_URI = 'mysql://' + DB_USER + ':' + DB_PASS + '@localhost/' + DB_NAME

Session = sessionmaker(bind=engine)
