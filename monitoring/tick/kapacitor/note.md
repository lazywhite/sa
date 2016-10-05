## Introduction
a data processing framework that make it easy to create alerts, run ETL jobs and detect anomalies

## Key concept

1. process both streaming data and batch data  
2. query data from influxdb on a schedule, and receive data via the line protocol and any other method influxdb supported  
3. perform any transformation currently possible in influxQL  
4. store transformed data back in influxdb  
5. add custom user defined functions to detect anomalies  
6. integreate widh hipchat, Slack , Alerta, Sensu and more  


## Keyword
```
task: an amount of work to do on a set of data
    type
        stream
        batch
    DSL: TICKscript

recording
replays


subscription
```

## Integreate with Slack



## Task example
### 1. create a cpu_alert.tick
```
stream
    // Select just the cpu measurement from our example database.
    |from()
        .database('telegraf')
        .retentionPolicy('autogen')
        .measurement('cpu')
    |alert()
        .crit(lambda: "usage_idle" <  95)
        // Whenever we get an alert write it to a file.
        .log('/tmp/alerts.log')
	    .slack()
        .channel('#alert')
```

### 2. define a task from tick file
```
kapacitor define cpu_alert \
    -type stream \
    -tick cpu_alert.tick \
    -dbrp kapacitor_example.default
```
