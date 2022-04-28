from encyclopedia import create_app, db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula

app = create_app()

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)

def get_pyramid(query, filter_by=1):
    # Get pyramid right from db
    # filter_by options:
    #   0: id
    #   1: sequence_number
    #   2: generating_function
    #   3: explicit_formula
    #   4: user_id
    
    filters = {
        0: Pyramid.id,
        1: Pyramid.sequence_number,
        2: Pyramid.generating_function,
        3: Pyramid.explicit_formula,
        4: Pyramid.user_id,
    }
    
    return Pyramid.query.filter(filters[filter_by]==query).first()
    
    
@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Pyramid': Pyramid, 'GeneratingFunction': GeneratingFunction,
    'ExplicitFormula': ExplicitFormula, 'relations': relations, 'Variable': Variable, 'Formula': Formula,
    'get_pyramid': get_pyramid}

@app.before_first_request
def create_tables():
    db.create_all()