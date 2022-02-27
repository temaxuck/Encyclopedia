from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_migrate import Migrate

# from redis import StrictRedis
# from redis_cache import RedisCache
# import jsonpickle

from config import Config


app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)
hasher = Bcrypt(app)
migrations = Migrate(app, db)
login_manager = LoginManager(app)
login_manager.login_view = 'login'
login_manager.login_message_category = 'info'

# redis_client = StrictRedis(host="127.0.0.1", port=6379, decode_responses=True, db=1)
# cacher = RedisCache(redis_client=redis_client, serializer=jsonpickle.encode)

from encyclopedia import routes