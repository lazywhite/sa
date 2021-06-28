## Intro
ntop 需要交换机端口镜像， 分析流量

## Install
```
yum -y install ntop

/etc/ntop.conf

    # tells ntop the user id to run as
    --user ntop

    #save messages into the system log
    --use-syslog=daemon

    # sets the directory that ntop runs from
    --db-file-path /var/lib/ntop

    # the amount and severity of messages that ntop will put out
    --trace-level 3

    # limit ntop to listening on a specific interface and port
    --http-server 0.0.0.0:3000
    #--https-server 0.0.0.0:3001

    # disables "phone home" behavior
    --skip-version-check=yes



/etc/init.d/ntop start

```
