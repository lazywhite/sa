## config
```
input {
    file {
        path => "/var/log/nginx/access.log"
        type => "node1_nginx_access"
        }
}

filter {
  grok {
    match => {
        "message" => "%{IPORHOST:client_ip}\s+(?:%{QS:none}|-)\s+(?:%{QS:username}|-)\s+\[%{HTTPDATE:time_local}\]\s+\"%{WORD:request_method}\s+%{URIPATHPARAM:path}\s+HTTP/%{NUMBER:httpversion}\"\s+%{NUMBER:status}\s+%{INT:body_bytes_sent} (?:%{QS:http_referer}|-)\s+%{QS:http_user_agent}\s(?:%{QS:x_forwarded}|-)"
    }
}
  geoip { source => "client_ip" }
}

output {
    redis{
        host => "localhost"
        port => 6379
        data_type => "list"
        key => 'logstash'
    }
     stdout { codec => rubydebug }
}

```

## nginx log format
```
log_format  main  '$remote_addr - $remote_user [$time_local] "$host" "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';

```
