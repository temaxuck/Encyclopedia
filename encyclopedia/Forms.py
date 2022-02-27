from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, BooleanField, SubmitField, EmailField, IntegerField, FieldList, FormField, Form
from wtforms.validators import InputRequired, Email, Length, EqualTo, ValidationError, NumberRange

from encyclopedia.models import User, Pyramid 
from flask_login import current_user

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

class UpdateProfileForm(FlaskForm):
    username = StringField('Username', validators=[InputRequired(), Length(min=5, max=30)])
    email = EmailField('E-mail', validators=[InputRequired(), Email(message="Invalid Email")])
    picture = FileField('Update profile picture', validators=[FileAllowed(['jpg', 'png', 'jpeg'])])

    submit = SubmitField('Save profile')
    
    def validate_username(self, username):
        if username.data.lower() != current_user.username:
            user = User.query.filter_by(username=username.data.lower()).first()
            if user:
                raise ValidationError('User with such username already exists.')
    
    def validate_email(self, email):
        if email.data.lower() != current_user.email:
            user = User.query.filter_by(email=email.data.lower()).first()
            if user:
                raise ValidationError('User with such email already exists.')

class GeneratingFunctionForm(Form):
    f_name = StringField('Function name', validators=[InputRequired()])
    f_vars = StringField('Function variables', validators=[InputRequired()])
    f_expr = StringField('Expression', validators=[InputRequired()])

class ExplicitFormula(Form):
    f_expr = StringField('Expression', validators=[InputRequired()])
    f_condition = StringField('Condition')


class UploadPyramidForm(FlaskForm):
    sequenceNumber = IntegerField('Sequence number', validators=[InputRequired(), NumberRange(min=0)])
    generatingFunction = FieldList(FormField(GeneratingFunctionForm), min_entries=1)
    explicitFormula = FieldList(FormField(ExplicitFormula), min_entries=1)
    ef_name = StringField('Formula name', validators=[InputRequired()], default="T")
    ef_vars = StringField('Formula variables', validators=[InputRequired()], default="n, m, k")
    # explicitFormula = StringField('Explicit formula', validators=[InputRequired()])
    relations = StringField('Relations with another pyramids', validators=[])

    submit = SubmitField('Upload pyramid')
    
    def validate_sequenceNumber(self, sequenceNumber):
        pyramid = Pyramid.query.filter_by(sequence_number=sequenceNumber.data).first()
        if pyramid:
            raise ValidationError('Pyramid with such sequence number already exists.')
        if sequenceNumber.data < 1:
            raise ValidationError("Pyramid's sequence number cannot be negative or equal to 0.")

    def validate_generatingFunction(self, generatingFunction):
        ...
