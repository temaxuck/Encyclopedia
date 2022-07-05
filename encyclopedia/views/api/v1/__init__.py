from encyclopedia.views.api import *
from .resources.Pyramid import Pyramid, PyramidList

apiv1bp = Blueprint('apiv1', __name__)
api = Api(apiv1bp)

api.add_resource(PyramidList, '/pyramids')
api.add_resource(Pyramid, '/pyramid/<int:sequence_number>')