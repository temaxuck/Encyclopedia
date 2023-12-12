from flask import (
    Blueprint,
    render_template,
    request,
    url_for,
    redirect,
    flash,
    current_app,
    g,
    session,
)
from flask_login import current_user, login_required
from encyclopedia import db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula
from encyclopedia.forms import SearchForm, ChooseLanguageForm
from encyclopedia import get_locale
from datetime import datetime
import sqlalchemy


@current_app.before_request
def before_request():
    g.search_form = SearchForm()
    g.locale = str(get_locale())
    g.choose_language_form = ChooseLanguageForm(language=g.locale)
    # g.choose_language_form.language.data =


@current_app.context_processor
def inject_now():
    return {"now": datetime.utcnow()}
