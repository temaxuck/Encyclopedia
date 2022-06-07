from flask import Blueprint, render_template, request, url_for, redirect, flash, current_app
from flask_login import login_user, current_user, logout_user, login_required
from encyclopedia import db, hasher, mail
from encyclopedia.forms import UploadPyramidForm, ExplicitFormulaForm, GeneratingFunctionForm, LoginForm, SignupForm, UpdateProfileForm, RelationForm
from encyclopedia.models import User, Pyramid, GeneratingFunction, ExplicitFormula
from sqlalchemy.orm import Session 
import sqlalchemy