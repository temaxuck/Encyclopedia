import os

class Config(object):
    SECRET_KEY = 'cc530c1746dc2c713ccd28936fc870d6f30106582ed09bef074f66376683ccc8'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///encyclopedia.db'
    # CACHE_TYPE = "RedisCache"
    # CACHE_REDIS_HOST = "0.0.0.0"
    # CACHE_REDIS_PORT = "5555"