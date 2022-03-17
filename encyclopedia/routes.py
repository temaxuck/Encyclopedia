from flask import render_template, request, url_for, redirect, session, flash
from flask_login import login_user, current_user, logout_user, login_required
from encyclopedia.models import User, Pyramid, relations, GeneratingFunction, Formula, ExplicitFormula
from encyclopedia.forms import LoginForm, SignupForm, UpdateProfileForm, UploadPyramidForm, GeneratingFunctionForm, ExplicitFormulaForm
from encyclopedia import app, db, hasher

import os
import datetime
import secrets
from werkzeug.utils import secure_filename

script_path = os.path.dirname(__file__)  # absolute dir the script is in
POSTS_PER_PAGE = 3

@app.route('/', methods=['POST', 'GET'])
def home():
    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))
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
        return redirect(url_for('home', page=1))
    
    pages_in_total = len(pyramid_list.all()) // POSTS_PER_PAGE
    if len(pyramid_list.all()) % POSTS_PER_PAGE:
        pages_in_total += 1
    return render_template('home.html', pyramids=pyramids, page=page, pages_in_total=pages_in_total)


@app.route('/pyramid/<snid>', methods=['POST', 'GET'])
def pyramid(snid: int):
    pyramid = Pyramid.query.filter_by(sequence_number=snid).first()

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))

    return render_template('pyramid.html', pyramid=pyramid, PyramidModel=Pyramid)

@app.route('/400',  methods=['POST', 'GET'])
def not_found():
    query = request.args.get('q')
    if not query:
        return redirect(url_for("home", is_empty=1))

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))
    
    return render_template('not_found.html', user_input=query)

# User Authentication System

@app.route('/login', methods=['POST', 'GET'])
def login():
    if current_user.is_authenticated:
        flash(f'You already have been logged in!', 'info')
        return redirect(url_for('home'))

    form = LoginForm()

    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data.lower()).first()
        if not user:
            user = User.query.filter_by(username=form.email.data.lower()).first()        

        if user and hasher.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember_me.data)
            flash(f'Logged as {user.username.capitalize()}!', 'success')
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('home'))
        else:
            flash(f'Login unsuccessful. Please check email/username and password', 'danger')

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))

    return render_template('login.html', form=form)

@app.route('/signup', methods=['POST', 'GET'])
def signup():
    if current_user.is_authenticated:
        flash(f'You already have been logged in!', 'danger')
        return redirect(url_for('home'))

    form = SignupForm()

    if form.validate_on_submit():
        hashed_pw = hasher.generate_password_hash(form.password.data).decode('utf-8')
        user = User(form.username.data.lower(), form.email.data.lower(), hashed_pw)
        db.session.add(user)
        db.session.commit()

        flash(f'Your account has been created! You are now able to log in!', 'success')
        return redirect(url_for('login'))

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))
    
    return render_template('signup.html', form=form)

@app.route('/logout')
def logout():
    logout_user()
    
    return redirect(url_for('home'))

@app.route('/users/<username>', methods=['POST', 'GET'])
@login_required
def account(username: str):
    user_account = User.query.filter_by(username=username).first() # user passed as an argument

    if not user_account:
        user_account = current_user
        return redirect(url_for('account', username=current_user.username))
    
    imagesrc = url_for('static', filename=f'profile_pictures/{user_account.profile_imagefile}')

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))

    return render_template('account.html', user=user_account, imagesrc=imagesrc)

@app.route('/users/edit/<id>', methods=['POST', 'GET'])
@login_required
def update_profile(id: int):
    user_account = User.query.filter_by(id=id).first() # user passed as an argument
    form = UpdateProfileForm()

    if (not user_account) or (user_account != current_user):
        user_account = current_user
        return redirect(url_for('account', username=current_user.username))

    if form.validate_on_submit():
        if form.picture.data:
            picture_filepath = upload_file(form.picture.data, current_user.id)
            current_user.profile_imagefile = picture_filepath

        current_user.username = form.username.data.lower()
        current_user.email = form.email.data.lower()
        
        db.session.commit()
        flash('Your account has been edited!', 'success')

        return redirect(url_for('account', username=current_user.username))
    
    elif request.method == 'GET':
        form.username.data = current_user.username.capitalize()
        form.email.data = current_user.email.capitalize()

    imagesrc = url_for('static', filename=f'profile_pictures/{user_account.profile_imagefile}')

    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))

    return render_template('update_profile.html', imagesrc=imagesrc, form=form)

def upload_file(form_file, user_id):
    new_filename = secrets.token_hex(8)
    new_filename += os.path.splitext(form_file.filename)[1]
    new_filename = secure_filename(new_filename)
    
    filedir = os.path.join(app.root_path, 'static', 'profile_pictures', str(user_id))
    if not os.path.isdir(filedir):
        print('Does not exist!', os.path.isfile(filedir))
        os.mkdir(filedir)
    
    filepath = os.path.join(filedir, new_filename)
    form_file.save(filepath)

    dbfilepath = f'{user_id}//{new_filename}'
    return dbfilepath


@app.route('/upload_pyramid', methods=['POST', 'GET'])
@login_required
def upload_pyramid():
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("home"))
        
    form = UploadPyramidForm()

    if form.validate_on_submit():
        alreadyExist = Pyramid.query.filter_by(sequence_number=form.sequenceNumber.data).count() > 0
        if alreadyExist:
            flash(f'Such pyramid already exists', 'danger')
            return redirect(url_for('upload_pyramid'))

        pyramid = Pyramid(form.sequenceNumber.data)
        


        rels = form.relations.data
        
        for i, gf in enumerate(form.generatingFunction):
            isMain = False
            if gf.f_name.data == 'U' or gf.f_name.data == 'u' or i == len(form.generatingFunction) - 1:
                isMain = True
            pyramid.add_generating_function(gf.f_name.data, gf.f_vars.data, gf.f_expr.data, isMain)
        
        for ef in form.explicitFormula:
            pyramid.add_explicit_formula(form.ef_vars.data, ef.f_expr.data, ef.f_condition.data)

        pyramid.init_special_value()
        # print(pyramid.init_special_value)
        alreadyExist = Pyramid.query.filter_by(__special_hashed_value__=pyramid.__special_hashed_value__).count() > 0
        
        if alreadyExist:
            flash(f'Such pyramid already exists', 'danger')
            return redirect(url_for('upload_pyramid'))

        db.session.add(pyramid)

        if rels != '':
            for rel in rels.split(','):
                try:
                    rel = int(rel)
                    related_pyramid = Pyramid.query.filter_by(sequence_number = rel).first()
                    if related_pyramid is None:
                        flash(f'Could not get Pyramid#{rel}', 'danger')
                    else:
                        pyramid.add_relation(related_pyramid)
                except ValueError:
                    flash(f'Could not convert Pyramid #{pyramid.sequence_number} relation {rel} to int', 'danger')

        current_user.add_pyramid(pyramid)
        db.session.commit()
        flash('The pyramid has been added!', 'success')

        return redirect(url_for('home', username=current_user.username))
    
    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))
    
    return render_template('upload_pyramid.html', form=form)

@app.route('/pyramid/<snid>/edit', methods=['POST', 'GET'])
@login_required
def edit_pyramid(snid: int):
    if not current_user.moderator:
        flash("You have no access to this page", "danger")
        return redirect(url_for("home"))
        
    form = UploadPyramidForm()
    pyramid = Pyramid.query.filter_by(sequence_number=snid).first()

    if form.validate_on_submit():
        rels = form.relations.data

        for i, gf in enumerate(form.generatingFunction):
            isMain = False
            if gf.f_name.data == 'U' or gf.f_name.data == 'u' or i == len(form.generatingFunction) - 1:
                isMain = True
            
            try:
                pyramid.generating_function[i].change_formula(
                        function_name=gf.f_name.data, 
                        variables=gf.f_vars.data, 
                        expression=gf.f_expr.data, 
                    )
            except IndexError:
                pyramid.add_generating_function(gf.f_name.data, gf.f_vars.data, gf.f_expr.data, isMain)
        
        for i, ef in enumerate(form.explicitFormula):
            try:
                pyramid.explicit_formula[i].change_formula(
                    expression=ef.f_expr.data, 
                    variables=form.ef_vars.data,
                    limitation=ef.f_condition.data
                )
            except IndexError:
                pyramid.add_explicit_formula(form.ef_vars.data, ef.f_expr.data, ef.f_condition.data)
        
        if form.relations.data != pyramid.get_relations_as_str():
            # pyramid.relations = []
            for relation in pyramid.relations.all():
                pyramid.delete_relation(relation)
            for rel in form.relations.data.split(','):
                related = Pyramid.query.filter_by(sequence_number=int(rel)).first()
                pyramid.add_relation(related)


        pyramid.init_special_value()
        db.session.commit()
        flash('The pyramid has been edited!', 'success')

        return redirect(url_for('pyramid', snid=pyramid.sequence_number))
    
    elif request.method == 'GET':
        form.sequenceNumber.data = pyramid.sequence_number
        form.generatingFunction[0].f_name.data = pyramid.generating_function[0].function_name
        form.generatingFunction[0].f_vars.data = pyramid.generating_function[0].get_variables_as_str()
        form.generatingFunction[0].f_expr.data = pyramid.generating_function[0].expression

        form.ef_name.data = pyramid.explicit_formula[0].function_name
        form.ef_vars.data = pyramid.explicit_formula[0].get_variables_as_str()
        form.explicitFormula[0].f_expr.data = pyramid.explicit_formula[0].expression
        form.explicitFormula[0].f_condition.data = pyramid.explicit_formula[0].limitation

        for i in range(len(pyramid.generating_function) - 1):
            gf = pyramid.generating_function[i+1]
            gform = GeneratingFunctionForm()
            gform.f_name = gf.function_name
            gform.f_vars = gf.get_variables_as_str()
            gform.f_expr = gf.expression
            form.generatingFunction.append_entry(gform)

        for i in range(len(pyramid.explicit_formula) - 1):
            ef = pyramid.explicit_formula[i+1]
            eform = ExplicitFormulaForm()
            eform.f_expr=ef.expression
            eform.f_condition=ef.limitation
            form.explicitFormula.append_entry(eform)

        form.relations.data = pyramid.get_relations_as_str()
    
    if request.method == 'POST':
        return redirect(url_for('search', q=request.form.get('pyramidinput')))
    
    return render_template('upload_pyramid.html', form=form, pyramid=pyramid)

@app.route('/search', methods=['POST', 'GET'])
def search():
    user_input = request.args.get('q')
    if user_input:
        try:
            query = int(user_input)
        except:
            query = user_input

        pyramid = Pyramid.query.filter_by(sequence_number=query).first()
        if pyramid:
            return redirect(url_for("pyramid", snid=pyramid.sequence_number))

        if not pyramid: # if not by sequence_number then by generating function
            pyramid = Pyramid.query.filter(Pyramid.generating_function.contains(GeneratingFunction.query.filter_by(expression=query).first())).first()
            if pyramid:
                return redirect(url_for("pyramid", snid=pyramid.sequence_number))

        if not pyramid: # if not by generating function then by explicit formula
            pyramid = Pyramid.query.filter(Pyramid.explicit_formula.contains(ExplicitFormula.query.filter_by(expression=query).first())).first()
            if pyramid:
                return redirect(url_for("pyramid", snid=pyramid.sequence_number))

        if not pyramid:
            try:
                query = query.split(',')
                query = list(map(int, query))
            except:
                return redirect(url_for("not_found", q=query))
            for pyr in Pyramid.query.all():
                try:
                    data = pyr.get_data_by_ef(7, 7, 1)
                    n = len(query)
                    if any(query == data[i:i + n] for i in range(len(data)-n + 1)):
                        return redirect(url_for("pyramid", snid=pyr.sequence_number))
                except:
                    return redirect(url_for("not_found", q=query))

        return redirect(url_for("pyramid", q=user_input))
    
    flash('Something went wrong', 'danger')
    return redirect(url_for("home"))