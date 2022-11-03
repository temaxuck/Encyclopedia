# import jwt
import redis
from celery import Celery
from config import Config
from flask import Flask, redirect, render_template, url_for
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_login import LoginManager
from flask_migrate import Migrate
from flask_msearch import Search
from flask_restful import Api
from flask_sqlalchemy import SQLAlchemy

# from flask_mail import Mail


db = SQLAlchemy()
hasher = Bcrypt()
search = Search()
# mail = Mail()
migrations = Migrate()
celery = Celery(__name__, broker=Config.CELERY_BROKER_URL)
redis_client = redis.Redis(host='localhost', port=6379, db=0)
redis_client_api = redis.Redis(host='localhost', port=6379, db=1)

login_manager = LoginManager()
login_manager.login_view = 'account.login'
login_manager.login_message = 'Please, log in to access this page'
login_manager.login_message_category = 'info'

# @login_manager.request_loader
# def load_user_from_request(request):
#     auth_headers = request.headers.get('Authorization', '').split()
#     if len(auth_headers) != 2:
#         return None
#     try:
#         token = auth_headers[1]
#         data = jwt.decode(token, current_app.config['SECRET_KEY'])
#         user = User.by_email(data['sub'])
#         if user:
#             return user
#     except jwt.ExpiredSignatureError:
#         return None
#     except (jwt.InvalidTokenError, Exception) as e:
#         return None
#     return None

def create_app():
    app = Flask(__name__)
    app.app_context().push()
    app.config.from_object(Config)
    db.init_app(app)
    # mail.init_app(app)
    hasher.init_app(app)
    migrations.init_app(app, db, render_as_batch=True)
    login_manager.init_app(app)
    search.init_app(app)
    celery.conf.update(app.config)
    # redis_client.init_app(app)
    # redis_client_api.init_app(app)
    
    # See errors.py to figure out why we handle it at this level
    @app.errorhandler(404)
    def page_not_found(e):
        return redirect(url_for('errors.error404'))

    # Register blueprints
    from encyclopedia.views.account import accountbp
    from encyclopedia.views.api import apibp
    from encyclopedia.views.errors import errorsbp
    from encyclopedia.views.general import generalbp
    from encyclopedia.views.pyramid import pyramidbp
    
    app.register_blueprint(errorsbp)
    app.register_blueprint(generalbp, url_prefix="/")
    app.register_blueprint(accountbp, url_prefix="/account")
    app.register_blueprint(pyramidbp, url_prefix="/pyramid")
    app.register_blueprint(apibp, url_prefix = '/api')

    CORS(generalbp)
    CORS(accountbp)
    CORS(pyramidbp)

    return app
