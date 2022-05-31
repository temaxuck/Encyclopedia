from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations, Variable, Formula

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
    