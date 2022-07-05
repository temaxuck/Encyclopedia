from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, BooleanField, SubmitField, EmailField, IntegerField, FieldList, SelectField, FormField, Form
from wtforms.validators import InputRequired, Email, Length, EqualTo, ValidationError, NumberRange, Optional

from encyclopedia.models import User, Pyramid, Formula, GeneratingFunction, ExplicitFormula
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

class GeneratingFunctionSubform(Form):
    f_name = StringField('Function name', validators=[InputRequired()], default="U")
    f_vars = StringField('Function variables', validators=[InputRequired()], default="x, y")
    f_expr = StringField('Expression', validators=[InputRequired()])

class ExplicitFormulaSubform(Form):
    f_expr = StringField('Expression', validators=[InputRequired()])
    f_condition = StringField('Condition')

class RelationSubform(Form):
    TAG_CHOICES = [
        ('Reciprocal', 'Reciprocal'),
        ('Reversion on y', 'Reversion on y'),
        ('Reversion on x', 'Reversion on x'),
        ('Right on x', 'Right on x'),
        ('Right on y', 'Right on y'),
        ('Left on x', 'Left on x'),
        ('Left on y', 'Left on y'),
        ('Change x y', 'Change x y'),
        (None, '--Select--'),
    ]
    relatedto_pyramid = IntegerField('Related to pyramid #', validators=[NumberRange(min=0), Optional()])
    tag = SelectField('Tag', choices=TAG_CHOICES)

class UploadPyramidForm(FlaskForm):
    sequenceNumber = IntegerField('Sequence number', validators=[InputRequired(), NumberRange(min=0)])
    generatingFunction = FieldList(FormField(GeneratingFunctionSubform), min_entries=1)
    explicitFormula = FieldList(FormField(ExplicitFormulaSubform), min_entries=1)
    ef_name = StringField('Formula name', validators=[InputRequired()], default="T")
    ef_vars = StringField('Formula variables', validators=[InputRequired()], default="n, m, k")
    relations = FieldList(FormField(RelationSubform), validators=[Optional()])
    submit = SubmitField('Upload pyramid')

    def validate_relations(self, relations):
        try:
            if relations.data:
                for rel in relations.data.split(','):
                    rel = int(rel)
                    Pyramid.query.filter_by(sequence_number=rel).one()
        except:
            raise ValidationError('Incorrect relations field')

class ConfirmPyramidDeletionForm(FlaskForm):
    submit = SubmitField('Delete pyramid')

class SearchForm(FlaskForm):
    q = StringField('Search', validators=[InputRequired()])
    
    def __init__(self, *args, **kwargs):
        from flask import request

        if 'formdata' not in kwargs:
            kwargs['formdata'] = request.args
        if 'csrf_enabled' not in kwargs:
            kwargs['csrf_enabled'] = False
        super(SearchForm, self).__init__(*args, **kwargs)

    class Meta:
        csrf = False
