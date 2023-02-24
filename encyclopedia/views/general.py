from encyclopedia.views import *
from encyclopedia import redis_client
from encyclopedia.search import DefaultSearch, PyramidDataSearch

generalbp = Blueprint('general', __name__)

@generalbp.route('/', methods=['GET'])
def home():
    return render_template('home.html')

@generalbp.route('/about', methods=['GET'])
def about():
    return render_template('about.html')

@generalbp.route('/book', methods=['GET'])
def book():
    return render_template('education.html')


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

            if not (results['exact'] or results['related']):
                return redirect(url_for("general.not_found", q=user_input))

            redis_client.set(f'{user_input}:{search_type}', json.dumps(results))
            redis_client.expire(user_input, 3600)
            return render_template('search.html', related=results['related'], exact=results['exact'], q=user_input)
            
    flash('Something went wrong', 'danger')
    return redirect(url_for("general.home"))

@generalbp.route('/choose_language', methods=['GET'])
def choose_language():
    if not g.choose_language_form.validate():
        return redirect(request.referrer)
    
    chosen_language = g.choose_language_form.language.data
    session['locale'] = chosen_language
    
    return redirect(request.referrer)
    