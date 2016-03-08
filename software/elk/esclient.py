from elasticsearch import Elasticsearch
from datetime import datetime


es = Elasticsearch()

print dir(es)
es.index(index='customer', doc_type='external', id=3, body={"name":"yellow star"})
print es.get(index='customer', doc_type='external', id=3)['_source']
