from flask import Blueprint, render_template, request, url_for, redirect, flash, current_app
from flask_login import current_user, login_required
from encyclopedia import db
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula
import sqlalchemy