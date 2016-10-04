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

subscription
```