def test_home_page_get(client):
    """
    GIVEN a configured for testing flask application
    WHEN the '/' page is requested(GET)
    THEN check that the response is valid
    """
    
    
    response = client.get('/')
    
    assert response.status_code == 200
    assert b'Online encyclopedia of Number Pyramids' in response.data
    assert b'Pyramid 1' in response.data
    assert b'Page' in response.data
        
def test_home_page_post(client):
    """
    GIVEN a configured for testing flask application
    WHEN the '/' page is requested(POST)
    THEN check whether client is redirected to '/search' route
    """
    
    response = client.post('/', data={'pyramidinput': '1'}, follow_redirects=True)
    assert response.status_code == 200
    assert len(response.history) == 1
    assert b'{\'id\': 206, \'sequence_number\': 81, ' in response.data
    
def test_home_page_post_empty(client):
    """
    GIVEN a configured for testing flask application
    WHEN the '/' page is requested(POST)
    THEN check whether client is redirected to '/not_found' route
    """
    
    response = client.post('/', data={'pyramidinput': ' 5555 '}, follow_redirects=True)
    assert b'did not match' in response.data