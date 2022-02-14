from flask import render_template, request, url_for, redirect, session, flash
from flask_login import login_user, current_user, logout_user, login_required
from encyclopedia.models import User, Pyramid, relations
from encyclopedia.forms import LoginForm, SignupForm
from encyclopedia import app, db, hasher
from encyclopedia.modules.PyramidsSystem2 import *

import os
import datetime
from werkzeug.utils import secure_filename

script_path = os.path.dirname(__file__)  # absolute dir the script is in


@app.route('/', methods=['POST', 'GET'])
def home():
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))

    return render_template('home.html')


@app.route('/pyramid', methods=['POST', 'GET'])
def pyramid():
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))

    query = request.args.get('q')

    try:
        Pyramid = get_user_input(query)
    except Exception as e:
        with open(os.path.join(script_path, 'bin', 'errorlog'), 'a') as f:
            print(f'[{datetime.datetime.now()}] {e}', file=f)
        if not query:
            flash(f'Pyramid expression cannot be empty!', 'danger')
            return redirect(url_for("home"))
        else:
            return redirect(url_for("not_found", q=query))


    try:
        relations = Pyramid.url.split('\n')
    except:
        relations = []

    for i in range(len(Pyramid.UUMaxima)):
        if Pyramid.UUMaxima[i] == 'Error convert': Pyramid.UUMaxima[i] = ''
    
    latexrepresenation = [latex(Pyramid.GeneratingFunction), latex(Pyramid.ExplicitFormula)]
    if Pyramid.GeneratingFunction != '':
        latexrepresenation[0] = 'UU' + str(Pyramid.spyr) + '(x,y) = ' + latexrepresenation[0]
    else:
        latexrepresenation[1] = 'LaTEX representation of Generating funciton is not ready yet...'
    
    if Pyramid.ExplicitFormula != '':
        latexrepresenation[1] = 'T_{' + str(Pyramid.pyr) + '}(n,m,k)=' + latexrepresenation[1]
    else:
        latexrepresenation[1] = 'LaTEX representation of Explicit formula is not ready yet...'

    return render_template('pyramid.html',
        Pyramid=Pyramid,
        relations=relations,
        latex=latexrepresenation
    )

@app.route('/400',  methods=['POST', 'GET'])
def not_found():
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))

    query = request.args.get('q')
    if not query:
        return redirect(url_for("home", is_empty=1))
    return render_template('not_found.html', user_input=query)

@app.route('/upload', methods=['POST', 'GET'])
def upload_pyramid():
    return render_template('upload.html')

@app.route('/getfile', methods=['POST', 'GET'])
def getfile():
    if request.method == 'POST':

        file = request.files['myfile']
        filename = secure_filename(file.filename) 

        # os.path.join is used so that paths work in every operating system
        file.save(os.path.join(script_path, "test", filename))

        # You should use os.path.join here too.
        with open(os.path.join(script_path, "test", filename)) as f:
            file_content = f.read()
            print(file_content)
     
        return file_content

    result = request.args.get['myfile']
    return result


# User Authentication System

@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))
    
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

    return render_template('login.html', form=form)

@app.route('/signup', methods=['POST', 'GET'])
def signup():
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))
    
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

    return render_template('signup.html', form=form)

@app.route('/logout')
def logout():
    logout_user()
    
    return redirect(url_for('home'))

@app.route('/users/<username>', methods=['POST', 'GET'])
@login_required
def account(username):
    if request.method == 'POST':
        user_input = request.form.get('pyramidinput')
        if user_input:
            return redirect(url_for("pyramid", q=user_input))
    
    imagesrc = url_for('static', filename=f'profile_pictures/{current_user.profile_imagefile}')
    return render_template('account.html', user=current_user, imagesrc=imagesrc)