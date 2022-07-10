# Database Handlers
# Used to adjust content of database
# Only to run it in python interactive shell 

from sqlalchemy import cast, text
from sqlalchemy.dialects.postgresql import ARRAY, array

from encyclopedia import create_app, db
from encyclopedia.models import Pyramid

app = create_app()

def delete_formulas_without_pyramid_id():
    sql_ex = text('DELETE FROM formula WHERE pyramid_id IS NULL;')

    with db.engine.connect() as conn:
        conn.execute(sql_ex)

def create_column_data_within_pyramid():
    sql_ex = text('ALTER TABLE pyramid ADD COLUMN data text[];')

    with db.engine.connect() as conn:
        conn.execute(sql_ex)

def insert_data_into_pyramid():
    for pyramid in Pyramid.query.all():
        print(f'Updating pyramid #{pyramid.sequence_number}')
        _data = list(map(str, pyramid.get_data_by_ef(7,7,1)))

        sql_ex = text("UPDATE pyramid SET data = :_data WHERE id = :_id;")

        with db.engine.connect() as conn:
            conn.execute(sql_ex, _data=_data, _id=pyramid.id)
        
def create_and_fill_data_column():
    create_column_data_within_pyramid()
    insert_data_into_pyramid()
    
def create_function_index_of_subarray():
    sql_ex = text('''
        CREATE OR REPLACE FUNCTION public.index_of_subarray(arr anyarray, sub anyarray)
        RETURNS integer
        LANGUAGE plpgsql
        IMMUTABLE
        AS $function$
        begin
            for i in 1 .. cardinality(arr)- cardinality(sub)+ 1 loop
                if arr[i:i+ cardinality(sub)- 1] = sub then
                    return i;
                end if;
            end loop;
            return NULL;
        end $function$''')

    with db.engine.connect() as conn:
        conn.execute(sql_ex)
            
def create_gin_index_for_data_column():
    sql_ex = text('''
    CREATE INDEX idx_gin_data ON pyramid USING GIN(data); 
    ''')
    
    with db.engine.connect() as conn:
        conn.execute(sql_ex)
    

def alter_pyramid_data_column_type_to_text_array():
    
    print('Process of altering has begun...')
    
    sql_ex = text('''
        ALTER TABLE pyramid
        ALTER data DROP DEFAULT,
        ALTER data TYPE text[] USING array[data],
        ALTER data SET DEFAULT '{}';
        ''')

    with db.engine.connect() as conn:
        conn.execute(sql_ex)
        
    print('Process of altering has finished...')
        