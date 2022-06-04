import os
import pytest

from encyclopedia import create_app, db as _db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula, relations

TEST_DATABASE_URI = 'postgresql:///test_encyclopedia'

@pytest.fixture(scope='session')
def app():
    app = create_app()
    app.config.update({
        'TESTING': True,
        'SQLALCHEMY_DATABASE_URI': TEST_DATABASE_URI
    })

    yield app


@pytest.fixture(scope='session')
def db(app, request):
    """Session-wide test database."""
    _db.app = app
    _db.create_all()

    return _db


@pytest.fixture(scope='function')
def session(db, request):
    """Creates a new database session for a test."""
    connection = db.engine.connect()
    transaction = connection.begin()

    options = dict(bind=connection, binds={})
    session = db.create_scoped_session(options=options)

    db.session = session

    def teardown():
        transaction.rollback()
        connection.close()
        session.remove()

    request.addfinalizer(teardown)
    return session


@pytest.fixture()
def client(app):
    return app.test_client()

@pytest.fixture()
def runner(app):
    return app.test_cli_runner()

@pytest.fixture(scope='module')
def new_user():
    user = User('damusername', 'damemail@email.com', 'unitt3sth3r3')
    user.id = 12000
    
    return user

@pytest.fixture(scope='module')
def new_pyramid():
    pyramid = Pyramid(2000)
    # pyramid.id = 2000
    
    return pyramid

@pytest.fixture(scope='module')
def another_pyramid():
    pyramid = Pyramid(2001)
    pyramid.id = 2001
    return pyramid

@pytest.fixture(scope='module')
def new_generatingFunction():
    gf = GeneratingFunction('U', 'x, y', '32132', True)
    gf.id = 6000
    return gf

@pytest.fixture(scope='module')
def relations_table():
    return relations

