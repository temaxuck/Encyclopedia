# from elasticsearch import Elasticsearch

# es = Elasticsearch('http://localhost:9300')

# es.index(index='my_index', id=1, document={'text': 'this is a test'})

def sqrt(value):
    if value < 0:
        return -1
    else:
        import math
        math.sqrt(value)

print(eval(
    '((x* (1-sqrt(1-4*y))**3) / (8 * y**3) + 1)**3',
    {'sqrt': sqrt, 'x': 30, 'y': 31})
)

import hashlib

hashlib.sha256()