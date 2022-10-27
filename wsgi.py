from encyclopedia import create_app, db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula
from encyclopedia.shell import get_pyramid, delete_last_ef
from encyclopedia.managers import PyramidManager

from flask import session, g

from dotenv import load_dotenv
import os
BASE_DIR = os.path.abspath(os.path.dirname(__file__))

app = create_app()

if __name__ == '__main__':
    load_dotenv(os.path.join(BASE_DIR, '.env'), override=True)
    app.run(debug=True, host=f"{os.environ.get('RUN_HOST')}", port=os.environ.get('RUN_PORT'))
    
@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Pyramid': Pyramid, 'GeneratingFunction': GeneratingFunction,
    'ExplicitFormula': ExplicitFormula, 'relations': relations, 'Variable': Variable, 'Formula': Formula,
    'get_pyramid': get_pyramid, 'delete_last_ef': delete_last_ef, 'PyramidManager': PyramidManager}

@app.before_first_request
def create_tables():
    db.create_all()

@app.before_request
def fix_missing_csrf_token():
    if app.config['WTF_CSRF_FIELD_NAME'] not in session:
        if app.config['WTF_CSRF_FIELD_NAME'] in g:
            g.pop(app.config['WTF_CSRF_FIELD_NAME'])