"""empty message

Revision ID: 598697c4e709
Revises: e91d3040fc87
Create Date: 2022-02-20 19:23:40.485894

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '598697c4e709'
down_revision = 'e91d3040fc87'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('formula', 'pyramid_id',
               existing_type=sa.INTEGER(),
               nullable=True)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('formula', 'pyramid_id',
               existing_type=sa.INTEGER(),
               nullable=False)
    # ### end Alembic commands ###
