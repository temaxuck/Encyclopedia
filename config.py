import os


class Config(object):
    SECRET_KEY = 'cc530c1746dc2c713ccd28936fc870d6f30106582ed09bef074f66376683ccc8'
    
    POSTGRES_USERNAME = os.environ.get('POSTGRES_USERNAME')
    POSTGRES_PASSWORD = os.environ.get('POSTGRES_PASSWORD')
    POSTGRES_HOST = os.environ.get('POSTGRES_HOST')
    POSTGRES_PORT = os.environ.get('POSTGRES_PORT')
    SQLALCHEMY_DATABASE_URI = f'postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/encyclopedia'
    
    RUN_HOST = os.environ.get('RUN_HOST')
    RUN_PORT = os.environ.get('RUN_PORT')
    
    MSEARCH_PRIMARY_KEY = 'id'
    MSEARCH_ENABLE = True
    REDIS_URL = "redis://:@localhost:6379/0"
    
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    
    # MAIL_SERVER ='smtp.gmail.com'
    # MAIL_PORT = 465
    # MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    # MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    # MAIL_DEFAULT_SENDER = os.environ.get('MAIL_USERNAME')
    # MAIL_USE_TLS = False
    # MAIL_USE_SSL = True