## Key concept
item
graph
expression
rule
scollector
    graphite
    collected

api
    /api/put
    /api/get
    /api/host
    /api/metric
    /api/health
    /api/rule
    /api/run
    /api/config


## Configuration
variable
    perform simple text replacement, not intelligent, they are any key whose name  
    begines with '$', and may be also surrounded by curly braces "{}"
    all variables are evaluted in the text, variables can be defined at any scope  
    and will shadow other variables with the same name of higher scape


Environment variable
    similarly to variables, but with 'env.' precedding the name
    it is an error to specify a non-existent or empty environment variable 

Sections
    globals
        globals are all key=value pairs not in a section, these are generally 
        placed at the top of the file, every variable is optional
    
    backends
        tsdb
        graphite
        logstash
        elasticsearch
        influx
            influxHost
            influxUsername
            influxPassword
            influxTLS
            influxTimeout


data storage
    bosun use redis as a storage mechanism for it's internal state, you can either
    run a redis instance to hold this data or bosun can use an embedded server if 
    you would rather run standalone \(using ledisDb\), redis is recommanded for 
    production use 

    redis

        redisHost
        redistDb
        redisPassword

    ledisDb
        ledisDir
        ledisBindAddr


settings
    checkFrequency
    defaultRunEvery
    emailFrom
    httpListen
    hostname
    ping
    stateFile
    shortUrlKey


SMTP Authentication
    smtpUsername
    smtpPassword


Macro
    Macros  are sections that can define anything \(including variablese\), It is 
    not an error to reference an unknown variable in a macro. Other sections can  
    reference the macro with "macro = name", the macro's data will be expanded with  
    the current variable definitions and inserted at that point in the section  
    Multiple macros may be thus referenced at any time. Macro may reference other  
    macros 


Template
    templates are the message body for emails that are sent when an alert is 
    triggered, syntax is the golang "text/template" package. Variable expansion  
    is not performed on templates because '$' is used in the template language  
    but a V() function is provided instead. Email body are HTML, subjects are 
    plaintext, Macro support is currently disabled for the same reason  

Variable available to alert tempaltes
    Ack
    Expr
    Group
    History
    Incident
    IsEmail
    Last
    Subject
    Touched
    Alert

Function availabe to alert templates
    Eval()
    EvalAll()
    GetMeta()
    Graph()
    GraphLink()
    Lookup()
    ESQuery()
Global template functions
    V
    bytes
    pct
    replace
    short
    parseDuration
    html

Unknow template
alert
    crit
    critNotifacation
    depends
    ignoreUnknown
    template
    warn
    warnNotification
    log
    
notification
    a notification is a chained action to perform, the chaining continues until  
    the chain ends or the alert is acknowledged, at least one action must be 
    specified. "next" and "timeout" are optional

    body
    next
    timeout
    contentType
    runOnActions

actions
    email
    get
    post
    print

lookup
    lookups are used when different values are needed based on the group

