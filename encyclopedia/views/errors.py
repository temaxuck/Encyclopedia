from encyclopedia.views import *

errorsbp = Blueprint('errors', __name__) 

# Cannot handle 404 routing errors because the 404 occurs at the routing level before the blueprint can be determined.
# @errorsbp.errorhandler(404)  
# def page_not_found(e):
#     print('handling 404')
#     return render_template('not_found.html', user_input=str(e)), 404