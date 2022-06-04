def test_login_page_get(client):
    """
    GIVEN a configured for testing flask application
    WHEN the '/account/login' page is requested(GET)
    THEN check that the response is valid
    """
    
    
    response = client.get('/account/login')
    
    assert response.status_code == 200
    assert b'Online encyclopedia of Number Pyramids' in response.data
    assert b'Log In' in response.data
    
