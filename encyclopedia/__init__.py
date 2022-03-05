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
app.elasticsearch = Elasticsearch([app.config['ELASTICSEARCH_URL']],
        basic_auth=(app.config["ELASTIC_USER"], app.config["ELASTIC_PASSWORD"]),
        ca_certs=False, verify_certs=False) if app.config['ELASTICSEARCH_URL'] else None

from encyclopedia import routes