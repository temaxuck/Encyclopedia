from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula
from encyclopedia import db

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
    
def delete_last_ef(sequence_number: int):
    pyr_id = get_pyramid(sequence_number).id
    formulas = Formula.query.filter_by(pyramid_id=pyr_id, type='explicitformula').all()
    print(formulas)
    order = int(input('Which one to delete? oo\n'))
    db.session.delete(formulas[order])
    db.session.commit()