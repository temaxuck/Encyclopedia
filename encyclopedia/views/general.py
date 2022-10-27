from encyclopedia.views import *
from encyclopedia import redis_client
from encyclopedia.search import DefaultSearch, PyramidDataSearch

generalbp = Blueprint('general', __name__)

POSTS_PER_PAGE = 20

# @generalbp.after_request 
# def after_request(response):
#     response.headers.add('Content-Type', 'text/html')
#     response.headers.add('Access-Control-Allow-Origin', '*')
#     response.headers.add('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
#     response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
#     response.headers.add('Access-Control-Expose-Headers', 'Content-Type,Content-Length,Authorization,X-Pagination')
# #     header = response.headers
# #     header['Access-Control-Allow-Origin'] = '*'
# #     # Other headers can be added here if needed
#     return response

@generalbp.route('/', methods=['GET'])
def home():

    page = request.args.get('page')
    try:
        page = int(page)
    except:
        page = 1
    if not page:
        page = 1
    pyramid_list = Pyramid.query.order_by(Pyramid.sequence_number)
    pyramids = pyramid_list[(page-1)*POSTS_PER_PAGE:(page)*POSTS_PER_PAGE]
    
    if not pyramids:
        return redirect(url_for('general.home', page=1))
    
    pages_in_total = len(pyramid_list.all()) // POSTS_PER_PAGE
    if len(pyramid_list.all()) % POSTS_PER_PAGE:
        pages_in_total += 1
        
    return render_template('home.html', pyramids=pyramids, page=page, pages_in_total=pages_in_total)

@generalbp.route('/not_found',  methods=['GET'])
def not_found():
    query = request.args.get('q')
    if not query:
        return redirect(url_for("general.home", is_empty=1))

    return render_template('not_found.html', user_input=query)

@generalbp.route('/search', methods=['GET'])
def search():
    import json

    if not g.search_form.validate():
        return redirect(url_for('general.home'))

    user_input = g.search_form.q.data
    search_type = g.search_form.search_type.data
    search_type = '0' if search_type == None else search_type

    if user_input:
        try:
            results = json.loads(redis_client.get(f'{user_input}:{search_type}'))
            return render_template('search.html', results=results, q=user_input)
        except TypeError:
            
            if search_type == '0':
                search = DefaultSearch(db.session, user_input)
            elif search_type == '1':
                search = PyramidDataSearch(db.session, user_input)
            
            results = search.search()

            if not results:
                return redirect(url_for("general.not_found", q=user_input))

            redis_client.set(f'{user_input}:{search_type}', json.dumps(results))
            redis_client.expire(user_input, 3600)
            return render_template('search.html', results=results, q=user_input)
            
    flash('Something went wrong', 'danger')
    return redirect(url_for("general.home"))
