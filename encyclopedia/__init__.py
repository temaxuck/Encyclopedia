from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_migrate import Migrate

app = Flask(__name__)
app.config['SECRET_KEY'] = 'cc530c1746dc2c713ccd28936fc870d6f30106582ed09bef074f66376683ccc8'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///encyclopedia.db'

db = SQLAlchemy(app)
hasher = Bcrypt(app)
migrations = Migrate(app, db)
login_manager = LoginManager(app)
login_manager.login_view = 'login'
login_manager.login_message_category = 'info'

from encyclopedia import routes