from flask import Blueprint, render_template, request, url_for, redirect, flash, current_app, g
from flask_login import current_user, login_required
from encyclopedia import db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula
from encyclopedia.forms import SearchForm
import sqlalchemy

@current_app.before_request
def before_request():
    g.search_form = SearchForm()
    # g.locale = str(get_locale())

