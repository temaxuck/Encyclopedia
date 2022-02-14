from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, EmailField
from wtforms.validators import InputRequired, Email, Length, EqualTo, ValidationError

from encyclopedia.models import User 

class LoginForm(FlaskForm):
    email = StringField('Username or Email', validators=[InputRequired(), Length(min=5, max=30)])
    password = PasswordField('Password', validators=[InputRequired(), Length(min=8, max=100)])
    remember_me = BooleanField('Remember me')
    submit = SubmitField('Log in')


class SignupForm(FlaskForm):
    username = StringField('Username', validators=[InputRequired(), Length(min=5, max=30)])
    email = EmailField('E-mail', validators=[InputRequired(), Email(message="Invalid Email")])
    password = PasswordField('Password', validators=[InputRequired(), Length(min=8, max=100)])
    confirm_password = PasswordField(
        'Confirm password', validators=[InputRequired(), EqualTo('password', message="Doesn't match password")]
    )
    submit = SubmitField('Sign up')
    
    def validate_username(self, username):
        user = User.query.filter_by(username=username.data.lower()).first()
        if user:
            raise ValidationError('User with such username already exists.')
    
    def validate_email(self, email):
        user = User.query.filter_by(email=email.data.lower()).first()
        if user:
            raise ValidationError('User with such email already exists.')
    
