from encyclopedia.views import *
from encyclopedia import redis_client

generalbp = Blueprint('general', __name__)

POSTS_PER_PAGE = 20

@generalbp.route('/', methods=['POST', 'GET'])
def home():
    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
    page = request.args.get('page')
    try:
        page = int(page)
    except:
        page = 1
    if not page:
        page = 1
    pyramid_list = Pyramid.query.order_by(Pyramid.sequence_number)
    pyramids = pyramid_list[(page-1)*POSTS_PER_PAGE:(page)*POSTS_PER_PAGE]
    
    # if not pyramids:
    #     return redirect(url_for('general.home', page=1))
    
    pages_in_total = len(pyramid_list.all()) // POSTS_PER_PAGE
    if len(pyramid_list.all()) % POSTS_PER_PAGE:
        pages_in_total += 1
        
    return render_template('home.html', pyramids=pyramids, page=page, pages_in_total=pages_in_total)

@generalbp.route('/400',  methods=['POST', 'GET'])
def not_found():
    query = request.args.get('q')
    if not query:
        return redirect(url_for("general.home", is_empty=1))

    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
    
    return render_template('not_found.html', user_input=query)

@generalbp.route('/search', methods=['POST', 'GET'])
def search():
    import json
    if request.method == 'POST':
        return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
    user_input = request.args.get('q')
    if user_input:
        try:
            results = json.loads(redis_client.get(user_input))
            return render_template('search.html', results=results, q=user_input)
        except TypeError:
            pyramid_results = Pyramid.query.msearch(user_input, fields=['sequence_number'], limit=50).all()
            gf_results = GeneratingFunction.query.msearch(user_input, fields=['expression'], limit=50).all()
            ef_results = ExplicitFormula.query.msearch(user_input, fields=['expression'], limit=50).all()
            user_results = User.query.msearch(user_input, fields=['username'], limit=50).all()
            results = list(map(lambda x: json.loads(x.toJSON()), pyramid_results))
            for result in gf_results + ef_results:
                try: results.append(json.loads(result.pyramid.toJSON()))
                except: ...
            
            for result in user_results:
                results.append(json.loads(result.toJSON()))

            if not results:
                return redirect(url_for("general.not_found", q=user_input))
                
            redis_client.set(user_input, json.dumps(results))
            redis_client.expire(user_input, 3600)
            return render_template('search.html', results=results, q=user_input)
        # except:
        #     flash('Something went wrong', 'danger')
        #     return redirect(url_for("general.home"))
            
    flash('Something went wrong', 'danger')
    return redirect(url_for("general.home"))
        
