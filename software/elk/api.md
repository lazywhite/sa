# ELK
curl localhost:9200/_nodes/process?pretty
curl 'localhost:9200/_cat/indices?v'
curl 'localhost:9200/_cat/nodes?v'
curl -XPUT 'localhost:9200/customer?pretty'
curl 'localhost:9200/_cat/indices?v'
curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
{
  "name": "John Doe"
}
curl -XDELETE 'localhost:9200/customer?pretty'
curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
{
  "name": "John Doe"
}'


## Plugins
bin/plugin -install karmi/elasticsearch-paramedic
bin/plugin --install mobz/elasticsearch-head
bin/plugin --install lukas-vlcek/bigdesk
bin/plugin --install lmenezes/elasticsearch-kopf/1.5.3
