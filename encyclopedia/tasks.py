import os

from celery import Celery
from flask import current_app
# import asyncio
import threading
import time

from encyclopedia import create_app, db, celery
from encyclopedia.models import Pyramid
from celery.contrib.abortable import AbortableTask

@celery.task(name='calculate_pyramid', time_limit=5)
def calculate_pyramid(pyrid, *args):
    pyr = db.session.query(Pyramid).filter_by(id=pyrid).first()
    val = pyr.evaluate_ef_at(*args)

    return val

