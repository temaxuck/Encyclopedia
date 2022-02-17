from encyclopedia import db
from encyclopedia.models import User, Pyramid, relations



# pyramids = Pyramid.query.all()
pyr1 = Pyramid.query.all()[0]
pyr2 = Pyramid.query.all()[1]

# pyr1.add_relation(pyr2)
# db.session.commit()
# pyr1.add_relation(pyr2)
# db.session.commit()

# pyr1.relations.drop()
# print(pyr1.relations.all())

# for el in pyr1.relations:
#     print(el.id)

# print(pyr1.relations)

'''
pyr1 = Pyramid(1, 'asdasdsadsad', 'sadsadsadsadsa')
>>> pyr2 = Pyramid(2, 'asdasd2121ad', 'sad21212121dsa')
'''