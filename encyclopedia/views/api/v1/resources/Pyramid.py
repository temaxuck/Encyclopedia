import hashlib
import json

from celery.exceptions import TimeLimitExceeded

from encyclopedia import redis_client_api
from encyclopedia.models import Pyramid as PyramidModel
from encyclopedia.tasks import calculate_pyramid

from .. import *


class Pyramid(Resource):
    def get(self, sequence_number):
        pyramid = PyramidModel.query.filter_by(sequence_number=sequence_number).first()

        if pyramid:
            return json.loads(pyramid.json())

        return {"message": f"Pyramid #{sequence_number} doesn't exist."}, 404


class PyramidList(Resource):
    def get(self):
        try:
            results = json.loads(redis_client_api.get("get_all_pyramids"))
            return results
        except TypeError:
            result = {
                "pyramids": [
                    json.loads(pyramid.toJSON())
                    for pyramid in PyramidModel.query.order_by(
                        PyramidModel.sequence_number
                    ).all()
                ]
            }
            # result = hashlib.sha256(result.encode()).hexdigest()
            redis_client_api.set("get_all_pyramids", json.dumps(result))
            return result


class PyramidCalculator(Resource):
    def get(self, sequence_number):
        pyramid = PyramidModel.query.filter_by(sequence_number=sequence_number).first()

        if pyramid:
            if pyramid.status[0] != 0:
                return {
                    "message": f"Pyramid #{sequence_number} is broken. Can't proceed calculating it's value.",
                    "value": None,
                }, 406

            # variables validation

            if len(request.args) != len(pyramid.explicit_formula[0].variables):
                return {
                    "message": f"Pyramid's explicit formula's variables do not match with ones in request.",
                    "value": None,
                }, 406

            pyr_keys = pyramid.explicit_formula[0].__get_variables_str__()

            req_keys_sorted = sorted(request.args.keys())
            pyr_keys_sorted = sorted(pyr_keys)

            if req_keys_sorted != pyr_keys_sorted:
                return {
                    "message": f"Pyramid's explicit formula's variables do not match with ones in request.",
                    "value": None,
                }, 406

            # evaluation
            try:
                _args = [int(request.args[var_name]) for var_name in pyr_keys]
            except:
                return {
                    "message": f"Could not convert values to integer values.",
                    "value": None,
                }, 406

            for val in _args:
                if val > 1000000000 or val < 0:
                    return {
                        "message": f"Invalid arguments' values.",
                        "value": None,
                    }, 406

            task = calculate_pyramid.apply_async(
                args=[pyramid.id, *_args], expires=30 * 60
            )

            try:
                return {"value": task.get()}, 200

            except TimeLimitExceeded as e:
                return {
                    "message": f"Calculations took way too long.",
                    "value": None,
                }, 406

            except Exception as e:
                return {
                    "message": f"Could not calulate pyramid's value with passed values.",
                    "exception": f"{e}",
                    "value": None,
                }, 406

        return {
            "message": f"Pyramid #{sequence_number} doesn't exist.",
            "value": None,
        }, 404
