## ES
```
rpm -ivh elasticsearch-2.3.4.rpm
```

### es-config file
```
cat /etc/elasticsearch/elasticsearch.yml
# ======================== Elasticsearch Configuration =========================
#
# NOTE: Elasticsearch comes with reasonable defaults for most settings.
#       Before you set out to tweak and tune the configuration, make sure you
#       understand what are you trying to accomplish and the consequences.
#
# The primary way of configuring a node is via this file. This template lists
# the most important settings you may want to configure for a production cluster.
#
# Please see the documentation for further information on configuration options:
# <http://www.elastic.co/guide/en/elasticsearch/reference/current/setup-configuration.html>
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#
cluster.name: test-cluster
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
node.name: test
#
# Add custom attributes to the node:
#
# node.rack: r1
#
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
path.data: /test/es
#
# Path to log files:
#
path.logs: /test/logs/es
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
bootstrap.mlockall: true
#
# Make sure that the `ES_HEAP_SIZE` environment variable is set to about half the memory
# available on the system and that the owner of the process is allowed to use this limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
#network.host: 10.24.36.231

# Disable starting multiple nodes on a single system:
#
node.max_local_storage_nodes: 1
#
# Require explicit names when deleting indices:
#
action.destructive_requires_name: true


###### index configure
index.number_of_shards: 1
index.number_of_replicas: 0


##### http configure

http.cors.enabled: true
http.cors.allow-origin: "*"
http.port: 9200

##### node configure
node.master: true
node.data: true

##### transport configure
transport.tcp.port: 9300

##### network configure
network.bind_host: ["0.0.0.0"]
network.publish_port: "10.24.36.231"

#cluster.routing.allocation.enable: all
```
### install plugins
```
./plugin install mobz/elasticsearch-head
./plugin install lmenezes/elasticsearch-kopf/master

http://host:9200/_plugin/<plugin_name>

```


## logstash
```
/etc/init.d/logstash
export JAVA_HOME=/usr/local/jdk-1.8
```

### agent
[Grok-online-debuger](https://grokdebug.herokuapp.com/)  

```
input {
    file {
        path => "/test/logs/nginx/access.log"
        type => "node1_nginx_access"
        }
}

filter {
  grok {
    match => {
        "message" => "%{IPORHOST:client_ip}\s+(?:%{QS:none}|-)\s+(?:%{QS:username}|-)\s+\[%{HTTPDATE:time_local}\]\s+\"%{HOSTNAME:hostname}\"\s+\"%{WORD:request_method}\s+%{URIPATHPARAM:path}\s+HTTP/%{NUMBER:httpversion}\"\s+%{NUMBER:status}\s+%{INT:body_bytes_sent} (?:%{QS:http_referer}|-)\s%{QS:http_user_agent}\s+(?:%{QS:http_x_cookie}|-)\s+\"%{NUMBER:request_time}\""
    }
}
  geoip { source => "client_ip" }
}

output {
    redis{
        host => "test"
        port => 7379
        data_type => "list"
        key => 'logstash'
    }
}
```
### tomcat 
```
input {
    file {
        codec => multiline {
            pattern => "(^\s)|(^com.test.*Exception)"
            what => "previous"
        }
        path => "/zj/java/tomcat_gateway/logs/gateway_log*.log"
        #path => "/zj/logs/tomcat/catalina.out.2016-07-19.out"
        #path => "/zj/logs/tomcat/catalina.out.%{+YYYY-MM-dd}.out"
        type => "gateway-02"
    }
}

filter {
    grok {
        match => {
            "message" => "%{YEAR:year}-%{MONTHNUM:month}-%{MONTHDAY:day}\s+%{HOUR:hour}:%{MINUTE:minute}:%{SECOND:second},%{BASE10NUM:ms}\s+%{LOGLEVEL:log_level}\s+%{JAVACLASS:class}\s+\[%{NOTSPACE:thread}\]\s-\s+(?<msg>.*$)"
        }
    }
}

output {
    redis{
        host => "test"
        port => 7379
        data_type => "list"
        key => 'logstash'
    }
#    stdout { codec => rubydebug }
}
```
### indexer
```
input {
  redis {
    host => "localhost"
    port => 7379
    data_type => "list"
    key => "logstash"
  }
}
output {
  elasticsearch {
    hosts => ["10.24.36.231:9200"]
    index => "logstash-%{+YYYY.MM.dd}"
  }
}
```

## Kibana
### config-file
```
  1 # Kibana is served by a back end server. This controls which port to use.
  2 server.port: 5601
  3
  4 # The host to bind the server to.
  5 server.host: "10.24.36.231"
  6
  7 # If you are running kibana behind a proxy, and want to mount it at a path,
  8 # specify that path here. The basePath can't end in a slash.
  9 # server.basePath: ""
 10
 11 # The maximum payload size in bytes on incoming server requests.
 12 # server.maxPayloadBytes: 1048576
 13
 14 # The Elasticsearch instance to use for all your queries.
 15 elasticsearch.url: "http://10.24.36.231:9200"
 16
 17 # preserve_elasticsearch_host true will send the hostname specified in `elasticsearch`. If you set it to false,
 18 # then the host you use to connect to *this* Kibana instance will be sent.
 19 # elasticsearch.preserveHost: true
 20
 21 # Kibana uses an index in Elasticsearch to store saved searches, visualizations
 22 # and dashboards. It will create a new index if it doesn't already exist.
 23 kibana.index: ".kibana"
 24
 25 # The default application to load.
 26 # kibana.defaultAppId: "discover"
 27
 28 # If your Elasticsearch is protected with basic auth, these are the user credentials
 29 # used by the Kibana server to perform maintenance on the kibana_index at startup. Your Kibana
 30 # users will still need to authenticate with Elasticsearch (which is proxied through
 31 # the Kibana server)
 32 # elasticsearch.username: "user"
 33 # elasticsearch.password: "pass"
 34
 35 # SSL for outgoing requests from the Kibana Server to the browser (PEM formatted)
 36 # server.ssl.cert: /path/to/your/server.crt
 37 # server.ssl.key: /path/to/your/server.key
 38
 39 # Optional setting to validate that your Elasticsearch backend uses the same key files (PEM formatted)
[root@rzj_test config]# cat kibana.yml
# Kibana is served by a back end server. This controls which port to use.
server.port: 5601

# The host to bind the server to.
server.host: "10.24.36.231"

# If you are running kibana behind a proxy, and want to mount it at a path,
# specify that path here. The basePath can't end in a slash.
# server.basePath: ""

# The maximum payload size in bytes on incoming server requests.
# server.maxPayloadBytes: 1048576

# The Elasticsearch instance to use for all your queries.
elasticsearch.url: "http://10.24.36.231:9200"

# preserve_elasticsearch_host true will send the hostname specified in `elasticsearch`. If you set it to false,
# then the host you use to connect to *this* Kibana instance will be sent.
# elasticsearch.preserveHost: true

# Kibana uses an index in Elasticsearch to store saved searches, visualizations
# and dashboards. It will create a new index if it doesn't already exist.
kibana.index: ".kibana"

# The default application to load.
# kibana.defaultAppId: "discover"

# If your Elasticsearch is protected with basic auth, these are the user credentials
# used by the Kibana server to perform maintenance on the kibana_index at startup. Your Kibana
# users will still need to authenticate with Elasticsearch (which is proxied through
# the Kibana server)
# elasticsearch.username: "user"
# elasticsearch.password: "pass"

# SSL for outgoing requests from the Kibana Server to the browser (PEM formatted)
# server.ssl.cert: /path/to/your/server.crt
# server.ssl.key: /path/to/your/server.key

# Optional setting to validate that your Elasticsearch backend uses the same key files (PEM formatted)
# elasticsearch.ssl.cert: /path/to/your/client.crt
# elasticsearch.ssl.key: /path/to/your/client.key

# If you need to provide a CA certificate for your Elasticsearch instance, put
# the path of the pem file here.
# elasticsearch.ssl.ca: /path/to/your/CA.pem

# Set to false to have a complete disregard for the validity of the SSL
# certificate.
elasticsearch.ssl.verify: false

# Time in milliseconds to wait for elasticsearch to respond to pings, defaults to
# request_timeout setting
# elasticsearch.pingTimeout: 1500

# Time in milliseconds to wait for responses from the back end or elasticsearch.
# This must be > 0
# elasticsearch.requestTimeout: 30000

# Time in milliseconds for Elasticsearch to wait for responses from shards.
# Set to 0 to disable.
# elasticsearch.shardTimeout: 0

# Time in milliseconds to wait for Elasticsearch at Kibana startup before retrying
# elasticsearch.startupTimeout: 5000

# Set the path to where you would like the process id file to be created.
# pid.file: /var/run/kibana.pid

# If you would like to send the log output to a file you can set the path below.
logging.dest:  /wdzj/logs/kibana/kibana.log

# Set this to true to suppress all logging output.
logging.silent: false

# Set this to true to suppress all logging output except for error messages.
logging.quiet: false

# Set this to true to log all events, including system usage information and all requests.
# logging.verbose: false

```
### delete object(virtualization, dashboard) from kibana
Setting->Objects
