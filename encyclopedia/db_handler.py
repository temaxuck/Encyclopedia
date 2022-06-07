from encyclopedia import db
from flask import current_app

def clean_up():
    """
    This method cleans up the session object and closes the connection pool using the dispose 
    method.
    """
    engine_container = db.get_engine(current_app)
    db.session.close()
    engine_container.dispose()