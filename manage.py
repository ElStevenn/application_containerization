from flask.cli import FlaskGroup
from flask_migrate import Migrate
from app import application, db

migrate = Migrate(application, db)

cli = FlaskGroup(application)

if __name__ == '__main__':
    cli()
