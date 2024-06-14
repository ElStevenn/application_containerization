from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand
from passenger_wsgi import application
from app import db

migrate = Migrate(application, db)
manager = Manager(application)

# Add the 'db' command to manager
manager.add_command('db', MigrateCommand)

if __name__ == '__main__':
    manager.run()
