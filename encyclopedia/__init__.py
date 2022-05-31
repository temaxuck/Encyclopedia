from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_migrate import Migrate
from flask_msearch import Search
from flask_redis import FlaskRedis

from config import Config

db = SQLAlchemy()
hasher = Bcrypt()
search = Search()
migrations = Migrate()
redis_client = FlaskRedis()
login_manager = LoginManager()
login_manager.login_view = 'account.login'
login_manager.login_message = 'Please log in to access this page'
login_manager.login_message_category = 'info'

def create_app():
    app = Flask(__name__)
    app.app_context().push()
    app.config.from_object(Config)
    db.init_app(app)
    hasher.init_app(app)
    migrations.init_app(app, db, render_as_batch=True)
    login_manager.init_app(app)
    search.init_app(app)
    redis_client.init_app(app)
    
    # See errors.py to figure out why we handle it at this level
    @app.errorhandler(404)
    def page_not_found(e):
        return render_template('page_not_found.html'), 404

    # Register blueprints
    from encyclopedia.views.errors import errorsbp
    from encyclopedia.views.general import generalbp
    from encyclopedia.views.account import accountbp
    from encyclopedia.views.pyramid import pyramidbp
    
    app.register_blueprint(errorsbp)
    app.register_blueprint(generalbp, url_prefix="/")
    app.register_blueprint(accountbp, url_prefix="/account")
    app.register_blueprint(pyramidbp, url_prefix="/pyramid")

    return app