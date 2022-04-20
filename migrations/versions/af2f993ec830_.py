"""empty message

Revision ID: af2f993ec830
Revises: 5d7d7b788c99
Create Date: 2022-02-25 14:34:55.766791

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'af2f993ec830'
down_revision = '5d7d7b788c99'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pyramid', sa.Column('__special_hashed_value__', sa.String(length=120), nullable=True))
    op.drop_column('pyramid', '_Pyramid__special_hashed_value_')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pyramid', sa.Column('_Pyramid__special_hashed_value_', sa.VARCHAR(length=120), nullable=True))
    op.drop_column('pyramid', '__special_hashed_value__')
    # ### end Alembic commands ###