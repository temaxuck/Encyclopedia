"""empty message

Revision ID: daeb4ee85c7a
Revises: 598697c4e709
Create Date: 2022-02-20 19:26:03.292770

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'daeb4ee85c7a'
down_revision = '598697c4e709'
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
               nullable=True)
    # ### end Alembic commands ###
