from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_migrate import Migrate
from elasticsearch import Elasticsearch

from config import Config

app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)
hasher = Bcrypt(app)
migrations = Migrate(app, db)
login_manager = LoginManager(app)
login_manager.login_view = 'login'
login_manager.login_message_category = 'info'
# es = Elasticsearch()

from encyclopedia import routes