from encyclopedia.views import *

errorsbp = Blueprint('errors', __name__) 

# Cannot handle 404 routing errors because the 404 occurs at the routing level before the blueprint can be determined.
# @errorsbp.errorhandler(404)  
# @errorsbp.route('/404', methods=['GET'])
# def error404():
#     return render_template('page_not_found.html'), 404
