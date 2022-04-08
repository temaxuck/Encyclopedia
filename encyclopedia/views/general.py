from encyclopedia.views import *

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
    user_input = request.args.get('q')
    if user_input:
        # search_results = Pyramid.query.msearch(user_input).all()
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
        # print(user_results)
        # print(search_results[0].update('gf_latex') = )
        # for result in search_results:
        #     result.
        # search_results.append(User.query.msearch(user_input, fields=['username']).all())
        # print(list(map(lambda x: json.loads(x.to_json(2)), search_results)))
        # page = request.args.get('page')
        # try:
        #     page = int(page)
        # except:
        #     page = 1

        if not results:
            return redirect(url_for("general.not_found", q=user_input))
        
        # pages_in_total = len(search_results.all()) // POSTS_PER_PAGE
        # if len(search_results.all()) % POSTS_PER_PAGE:
        #     pages_in_total += 1
        
        if request.method == 'POST':
            return redirect(url_for('general.search', q=request.form.get('pyramidinput')))
        
        return render_template('search.html', results=results, q=user_input)
    
    flash('Something went wrong', 'danger')
    return redirect(url_for("general.home"))

# @generalbp.route('/search', methods=['POST', 'GET'])
# def search():
#     user_input = request.args.get('q')
#     if user_input:
#         try:
#             query = int(user_input)
#         except:
#             query = user_input

#         pyramid = Pyramid.query.filter_by(sequence_number=query).first()
#         if pyramid:
#             return redirect(url_for("pyramid.pyramid", snid=pyramid.sequence_number))

#         if not pyramid: # if not by sequence_number then by generating function
#             pyramid = Pyramid.query.filter(Pyramid.generating_function.contains(GeneratingFunction.query.filter_by(expression=query).first())).first()
#             if pyramid:
#                 return redirect(url_for("pyramid.pyramid", snid=pyramid.sequence_number))

#         if not pyramid: # if not by generating function then by explicit formula
#             pyramid = Pyramid.query.filter(Pyramid.explicit_formula.contains(ExplicitFormula.query.filter_by(expression=query).first())).first()
#             if pyramid:
#                 return redirect(url_for("pyramid.pyramid", snid=pyramid.sequence_number))

#         if not pyramid:
#             try:
#                 query = query.split(',')
#                 query = list(map(int, query))
#             except:
#                 return redirect(url_for("general.not_found", q=query))
#             for pyr in Pyramid.query.all():
#                 try:
#                     data = pyr.get_data_by_ef(7, 7, 1)
#                     n = len(query)
#                     if any(query == data[i:i + n] for i in range(len(data)-n + 1)):
#                         return redirect(url_for("pyramid.pyramid", snid=pyr.sequence_number))
#                 except:
#                     return redirect(url_for("general.not_found", q=query))

#         return redirect(url_for("pyramid.pyramid", q=user_input))
    
#     flash('Something went wrong', 'danger')
#     return redirect(url_for("general.home"))