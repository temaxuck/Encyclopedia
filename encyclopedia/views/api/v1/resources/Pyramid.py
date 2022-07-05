import hashlib
import json

from encyclopedia import redis_client_api
from encyclopedia.models import Pyramid as PyramidModel

from .. import *


class Pyramid(Resource):
    
    def get(self, sequence_number):
        
        pyramid = PyramidModel.query.filter_by(sequence_number=sequence_number).first()
        
        if pyramid: 
            return json.loads(pyramid.toJSON())

        return {'message': f'Pyramid #{sequence_number} doesn\'t exist.'}, 404

class PyramidList(Resource):

    def get(self):

        try:
            results = json.loads(redis_client_api.get('get_all_pyramids'))
            return results
        except TypeError:
            result = {'pyramids': [json.loads(pyramid.toJSON()) for pyramid in PyramidModel.query.order_by(PyramidModel.sequence_number).all()]}
            # result = hashlib.sha256(result.encode()).hexdigest()
            redis_client_api.set('get_all_pyramids', json.dumps(result))
            return result
