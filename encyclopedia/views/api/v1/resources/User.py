from .. import *

class User(Resource):
    def get(self):
        return {'hello': 'world'}
