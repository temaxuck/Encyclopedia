from flask import Blueprint, render_template, request, url_for, redirect, flash, current_app, g, session
from flask_login import current_user, login_required
from encyclopedia import db, get_locale
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula
from encyclopedia.forms import SearchForm, ChooseLanguageForm
from datetime import datetime
from flask.sessions import SecureCookieSessionInterface
import sqlalchemy

session_cookie = SecureCookieSessionInterface().get_signing_serializer(current_app)

@current_app.before_request
def before_request():
    g.search_form = SearchForm()
    g.choose_language_form = ChooseLanguageForm(language=session.get('locale'))

@current_app.after_request
def cookies(response):
    same_cookie = session_cookie.dumps(dict(session))
    response.headers.add("Set-Cookie", f"my_cookie={same_cookie}; Secure; HttpOnly; SameSite=None; Path=/;")
    return response

@current_app.context_processor
def inject_now():
    return {'now': datetime.utcnow()}