from encyclopedia import create_app, db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula

app = create_app()

if __name__ == '__main__':
    app.run(debug=True, host="192.168.0.2", port=5000)

@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Pyramid': Pyramid, 'GeneratingFunction': GeneratingFunction,
    'ExplicitFormula': ExplicitFormula, 'relations': relations, 'Variable': Variable, 'Formula': Formula}

@app.before_first_request
def create_tables():
    db.create_all()