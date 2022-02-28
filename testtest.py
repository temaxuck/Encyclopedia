from elasticsearch import Elasticsearch

es = Elasticsearch('http://localhost:9300')

es.index(index='my_index', id=1, document={'text': 'this is a test'})