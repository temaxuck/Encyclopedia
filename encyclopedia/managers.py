from encyclopedia import db
from encyclopedia.models import Pyramid

class PyramidManager():
    db_session = None

    def __init__(self, db_session):
        self.db_session = db_session

    def delete(self, pyramid):
        self.db_session.delete(pyramid)
        self.db_session.commit()