from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_migrate import Migrate
from flask_msearch import Search

from config import Config

db = SQLAlchemy()
hasher = Bcrypt()
migrations = Migrate()
login_manager = LoginManager()
login_manager.login_view = 'account.login'
login_manager.login_message = 'Please log in to access this page'
login_manager.login_message_category = 'info'

search = Search()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    hasher.init_app(app)
    migrations.init_app(app, db, render_as_batch=True)
    login_manager.init_app(app)
    search.init_app(app)
    
    
    # app.elasticsearch = Elasticsearch([app.config['ELASTICSEARCH_URL']],
    #         basic_auth=(app.config["ELASTIC_USER"], app.config["ELASTIC_PASSWORD"]),
    #         ca_certs=False, verify_certs=False) if app.config['ELASTICSEARCH_URL'] else None

    # register blueprints
    from encyclopedia.views.general import generalbp
    from encyclopedia.views.account import accountbp
    from encyclopedia.views.pyramid import pyramidbp
    app.register_blueprint(generalbp, url_prefix="/")
    app.register_blueprint(accountbp, url_prefix="/account")
    app.register_blueprint(pyramidbp, url_prefix="/pyramid")

    return app