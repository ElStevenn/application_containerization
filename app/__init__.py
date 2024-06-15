from flask import Flask
from flask_wtf.csrf import CSRFProtect
from flask_sqlalchemy import SQLAlchemy

csrf = CSRFProtect()
db = SQLAlchemy()

def create_app():
    application = Flask(__name__)
    csrf.init_app(application)
    application.config.from_object('config')
    
    db.init_app(application)
    
    return application

application = create_app()

from app.models import Task
from app.controllers import *
