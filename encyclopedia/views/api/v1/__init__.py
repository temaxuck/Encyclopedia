from encyclopedia.views.api import *
from .resources.Pyramid import Pyramid, PyramidList, PyramidCalculator

apiv1bp = Blueprint('apiv1', __name__)
api = Api(apiv1bp)

api.add_resource(PyramidList, '/pyramids')
api.add_resource(Pyramid, '/pyramid/<int:sequence_number>')
api.add_resource(PyramidCalculator, '/pyramid/<int:sequence_number>/calculate')