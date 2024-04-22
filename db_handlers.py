# Database Handlers
# Used to adjust content of database

from sqlalchemy import cast, text
from sqlalchemy.dialects.postgresql import ARRAY, array

from encyclopedia import create_app, db
from encyclopedia.models import Pyramid, Formula

app = create_app()


def delete_formulas_without_pyramid_id():
    sql_ex = text("DELETE FROM formula WHERE pyramid_id IS NULL;")

    with db.engine.connect() as conn:
        conn.execute(sql_ex)


def insert_data_into_pyramids():
    for pyramid in Pyramid.query.all():
        if pyramid.data is None:
            print(f"Updating pyramid #{pyramid.sequence_number}")
            _data = list(map(str, pyramid.get_data_by_ef(7, 7, 1)))

            sql_ex = text("UPDATE pyramid SET data = :_data WHERE id = :_id")

            with db.engine.connect() as conn:
                conn.execute(sql_ex, _data=_data, _id=pyramid.id)


def insert_data_into_pyramid(sequence_number):
    pyramid = Pyramid.query.filter_by(sequence_number=sequence_number).first()
    _data = list(map(str, pyramid.get_data_by_ef(7, 7, 1)))

    sql_ex = text("UPDATE pyramid SET data = :_data WHERE id = :_id")

    with db.engine.connect() as conn:
        conn.execute(sql_ex, _data=_data, _id=pyramid.id)


def sympify_all_formulas():
    from sympy import sympify

    with open("temp.txt", "w") as f:
        for formula in Formula.query.all():
            try:
                print(formula.pyramid_id, file=f)
                formula.expression = str(sympify(formula.expression))
                db.session.commit()
            except Exception:
                print("Exception thrown:", Exception)
