from encyclopedia.views import *
from flask import jsonify
from flask_restful import Api, Resource, abort

from .v1 import apiv1bp

apibp = Blueprint('api', __name__)
apibp.register_blueprint(apiv1bp, url_prefix='v1')
