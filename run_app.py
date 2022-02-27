from encyclopedia import app, db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula

@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Pyramid': Pyramid, 'GeneratingFunction': GeneratingFunction,
    'ExplicitFormula': ExplicitFormula, 'relations': relations, 'Variable': Variable, 'Formula': Formula}

@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)