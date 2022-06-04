def test_new_user(new_user):
    """
    GIVEN a User model
    WHEN a new User is created
    THEN check it's email and password are defined correctly
    """

    assert new_user.email == 'damemail@email.com'
    assert new_user.password != 'unitt3sth3r3'
    
def test_new_pyramid(new_pyramid):
    """
    GIVEN a Pyramid model
    WHEN a new Pyramid is created
    THEN check it's sequence_number is defined correctly
    """
    
    assert new_pyramid.sequence_number == 2000
    
def test_new_user_add_pyramid(new_user, new_pyramid):
    """
    GIVEN a Pyramid model and User model
    WHEN the user adds the pyramid
    THEN check the pyramid has been added correctly
    """
    
    new_user.add_pyramid(new_pyramid)
    assert new_pyramid.user_id == 12000
    
def test_new_pyramid_add_relation(session, new_pyramid, another_pyramid):
    """
    GIVEN a Pyramid model and User model
    WHEN the user adds the pyramid
    THEN check the pyramid has been added correctly
    """
    session.add(new_pyramid)
    session.add(another_pyramid)
    new_pyramid.add_relation(another_pyramid.id, 'Change x y')
    assert another_pyramid in new_pyramid.relations
        
def test_new_pyramid_add_generating_function(session, new_pyramid, relations_table):
    """
    GIVEN a Pyramid model and User model
    WHEN the user adds the pyramid
    THEN check the pyramid has been added correctly
    """ 
    session.add(new_pyramid)
    print(session.query(relations_table).all())
    new_pyramid.add_generating_function('U', 'x, y', '32132', True)
    assert new_pyramid.generating_function[0].expression == '32132'
    