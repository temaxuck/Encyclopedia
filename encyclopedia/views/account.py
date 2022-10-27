from encyclopedia.views import *
from encyclopedia.forms import LoginForm, SignupForm, UpdateProfileForm
from flask_login import login_user, logout_user
from encyclopedia import hasher, csrf
from flask_cors import CORS
from flask import session, current_app, g

import os
import secrets
from werkzeug.utils import secure_filename


accountbp = Blueprint('account', __name__)

@accountbp.route('/login', methods=['POST', 'GET'])
def login():
    if current_user.is_authenticated:
        flash(f'You already have been logged in!', 'info')
        return redirect(url_for('general.home'))

    form = LoginForm(request.form)
    # flash(f'{request.form}', 'info')
    # flash(f'{session}', 'info')
    
    # flash(f'{current_app.secret_key}', 'info')
    
    if request.method == 'POST' and form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data.lower()).first()
        if not user:
            user = User.query.filter_by(username=form.email.data.lower()).first()        

        if user and hasher.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember_me.data)
            flash(f'Logged as {user.username.capitalize()}!', 'success')
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('general.home'))
        else:
            flash(f'Login unsuccessful. Please check email/username and password', 'danger')
    else:
        flash(f'{form.errors}', 'danger')
        return render_template('login.html', form=form)

@accountbp.route('/signup', methods=['POST', 'GET'])
def signup():
    if current_user.is_authenticated:
        flash(f'You already have been logged in!', 'danger')
        return redirect(url_for('general.home'))

    form = SignupForm()

    if form.validate_on_submit():
        user = User(form.username.data.lower(), form.email.data.lower(), form.password.data)
        db.session.add(user)
        db.session.commit()

        flash(f'Your account has been created! You are now able to log in!', 'success')
        return redirect(url_for('account.login'))

    return render_template('signup.html', form=form)

@accountbp.route('/logout')
def logout():
    logout_user()
    
    return redirect(url_for('general.home'))

@accountbp.route('/<username>', methods=['GET'])
@login_required
def account(username: str):
    user_account = User.query.filter_by(username=username).first() # user passed as an argument

    if not user_account:
        user_account = current_user
        return redirect(url_for('account.account', username=current_user.username))
    
    imagesrc = url_for('static', filename=f'profile_pictures/{user_account.profile_imagefile}')

    return render_template('account.html', user=user_account, imagesrc=imagesrc)

@accountbp.route('/edit/<id>', methods=['POST', 'GET'])
@login_required
def update_profile(id: int):
    try:
        user_account = User.query.filter_by(id=id).first() # user passed as an argument
    except sqlalchemy.exc.DataError:
        return redirect(url_for('errors.error404'))

    form = UpdateProfileForm()

    if (not user_account) or (user_account != current_user):
        user_account = current_user
        return redirect(url_for('account.account', username=current_user.username))

    if form.validate_on_submit():
        if form.picture.data:
            picture_filepath = upload_file(form.picture.data, current_user.id)
            current_user.profile_imagefile = picture_filepath

        current_user.username = form.username.data.lower()
        current_user.email = form.email.data.lower()
        
        db.session.commit()
        flash('Your account has been edited!', 'success')

        return redirect(url_for('account.account', username=current_user.username))
    
    elif request.method == 'GET':
        form.username.data = current_user.username.capitalize()
        form.email.data = current_user.email.capitalize()

    imagesrc = url_for('static', filename=f'profile_pictures/{user_account.profile_imagefile}')

    return render_template('update_profile.html', imagesrc=imagesrc, form=form)

def upload_file(form_file, user_id):
    new_filename = secrets.token_hex(8)
    new_filename += os.path.splitext(form_file.filename)[1]
    new_filename = secure_filename(new_filename)
    
    filedir = os.path.join(current_app.root_path, 'static', 'profile_pictures', str(user_id))
    if not os.path.isdir(filedir):
        print('Does not exist!', os.path.isfile(filedir))
        os.mkdir(filedir)
    
    filepath = os.path.join(filedir, new_filename)
    form_file.save(filepath)

    dbfilepath = f'{user_id}/{new_filename}'
    return dbfilepath

# @accountbp.route('/test', methods=['POST', 'GET'])
# def test():
#     if request.method == 'POST':
#         return {'message': 'Successful posted some data'}, 201
    
#     return "Hello, World!"