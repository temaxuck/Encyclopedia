# Database Handlers
# Used to adjust content of database

from sqlalchemy import cast, text
from sqlalchemy.dialects.postgresql import ARRAY, array

from encyclopedia import create_app, db
from encyclopedia.models import Pyramid

app = create_app()

def delete_formulas_without_pyramid_id():
    sql_ex = text('DELETE FROM formula WHERE pyramid_id IS NULL;')

    with db.engine.connect() as conn:
        conn.execute(sql_ex)

def insert_data_into_pyramid():
    for pyramid in Pyramid.query.all():
        print(f'Updating pyramid #{pyramid.sequence_number}')
        _data = list(map(str, pyramid.get_data_by_ef(7,7,1)))

        sql_ex = text("UPDATE pyramid SET data = :_data WHERE id = :_id")

        with db.engine.connect() as conn:
            conn.execute(sql_ex, _data=_data, _id=pyramid.id)
