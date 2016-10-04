## Introduction
>Telegraf is a plugin-driven server agent for collecting & report metrics

> Telegraf has plugins to source a variety of metrics directly from the system 
it's running on. pull metrics from third party APIs, or even listen for 
metrics via a statsd and Kafka consumer services, It also has output plugin 
to sent metrics to a variety of other datastores, services, and message queues
including Influxdb, Graphite, OpenTSDB, Datadog, Librato, Kafaka, MQTT, NSQ
and many others

## Key Featuers
1. written in go, compiled into a single binary without other dependencies  
2. minimal memory footprint  
3. plugin system allow new inputs and outputs to be easily added  
4. a wide number of plugins for manu popular services already exists for 
well known serivces and APIs   



## Plugin
### docker
```
# /usr/local/etc/telegraf.d/docker.conf

[[inputs.docker]]
  # Docker Endpoint
  #   To use TCP, set endpoint = "tcp://[ip]:[port]"
  #   To use environment variables (ie, docker-machine), set endpoint = "ENV"
  endpoint = "unix:///var/run/docker.sock"
  # Only collect metrics for these containers, collect all if empty
  container_names = []
```

