import json

from encyclopedia import redis_client
from encyclopedia.models import Pyramid as PyramidModel
from encyclopedia.search import DefaultSearch, PyramidDataSearch
from flask_restful import reqparse

from .. import *


class Search(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument("search_type", type=int, location="args")
        parser.add_argument("search_query", type=str, location="args")
        args = parser.parse_args()

        search_type = str(args["search_type"])
        search_query = args["search_query"]

        if search_type is None and search_query is None:
            return {
                "error": "Specify search_type and search_query parameters. Example of request: /api/v1/search?search_type=0&search_query=2"
            }

        search_type = "0" if search_type not in ("0", "1") else search_type

        try:
            results = json.loads(redis_client.get(f"{search_query}:{search_type}"))
            return results
        except TypeError:
            if search_type == "0":
                search = DefaultSearch(db.session, search_query)
            elif search_type == "1":
                search = PyramidDataSearch(db.session, search_query)

            results = search.search(is_api_search=True)

            if not (results["exact"] or results["related"]):
                return {"exact": [], "related": []}

            redis_client.set(f"{search_query}:{search_type}", json.dumps(results))
            redis_client.expire(search_query, 3600)
            return results
