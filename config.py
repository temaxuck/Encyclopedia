import os

class Config(object):
    SECRET_KEY = 'cc530c1746dc2c713ccd28936fc870d6f30106582ed09bef074f66376683ccc8'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///encyclopedia.db'
    # MSEARCH_BACKEND = 'whoosh'
    # WHOOSH_BASE = 'whoosh'
    MSEARCH_PRIMARY_KEY = 'id'
    MSEARCH_ENABLE = True
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    # ELASTICSEARCH_URL = os.environ.get('ELASTICSEARCH_URL')
    # ELASTIC_USER = os.environ.get("ELASTIC_USER")
    # ELASTIC_PASSWORD = os.environ.get("ELASTIC_PASSWORD")