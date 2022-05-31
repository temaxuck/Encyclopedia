import os

class Config(object):
    SECRET_KEY = 'cc530c1746dc2c713ccd28936fc870d6f30106582ed09bef074f66376683ccc8'
    POSTGRES_USERNAME = os.environ.get('POSTGRES_USERNAME')
    POSTGRES_PASSWORD = os.environ.get('POSTGRES_PASSWORD')
    POSTGRES_HOST = os.environ.get('POSTGRES_HOST')
    POSTGRES_PORT = os.environ.get('POSTGRES_PORT')
    SQLALCHEMY_DATABASE_URI = f'postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/encyclopedia'
    # MSEARCH_BACKEND = 'whoosh'
    # WHOOSH_BASE = 'whoosh'
    MSEARCH_PRIMARY_KEY = 'id'
    MSEARCH_ENABLE = True
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    REDIS_URL = "redis://:@localhost:6379/0"
    # ELASTICSEARCH_URL = os.environ.get('ELASTICSEARCH_URL')
    # ELASTIC_USER = os.environ.get("ELASTIC_USER")
    # ELASTIC_PASSWORD = os.environ.get("ELASTIC_PASSWORD")