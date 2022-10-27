import os


class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY')
    # SERVER_NAME = 'localhost:8000'
    
    DEBUG = os.environ.get('DEBUG')
    
    POSTGRES_USERNAME = os.environ.get('POSTGRES_USERNAME')
    POSTGRES_PASSWORD = os.environ.get('POSTGRES_PASSWORD')
    POSTGRES_HOST = os.environ.get('POSTGRES_HOST')
    POSTGRES_PORT = os.environ.get('POSTGRES_PORT')
    SQLALCHEMY_DATABASE_URI = f'postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/encyclopedia'
    
    RUN_HOST = os.environ.get('RUN_HOST')
    RUN_PORT = os.environ.get('RUN_PORT')
    
    
    WTF_CSRF_ENABLED = True
    WTF_CSRF_SECRET_KEY = os.environ.get('SECRET_KEY')
    SESSION_COOKIE_SECURE =  False
    REMEMBER_COOKIE_SECURE =  True
    
    MSEARCH_PRIMARY_KEY = 'id'
    MSEARCH_ENABLE = True
    REDIS_URL = "redis://:@localhost:6379/0"
    
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    SQLALCHEMY_ENGINE_OPTIONS = {
        'pool_size': 30,
        'pool_timeout': 50
        }
    
    MAIL_SERVER ='smtp.gmail.com'
    MAIL_PORT = 465
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    MAIL_DEFAULT_SENDER = os.environ.get('MAIL_USERNAME')
    MAIL_USE_TLS = False
    MAIL_USE_SSL = True