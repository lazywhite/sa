## Keyword
team    
channel  
direct message  

## Webhook
```
url
    https://hooks.slack.com/services/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
sending message
    1. send a json string as the "payload" parameter of POST request
    2. send a json string as th body of POST request

add links
     <https://alert-system.com/alerts/1234|Click here>
customized apperence
    1. icon
        "icon_url": "<url>"
        "icon_emoji": ":ghost:"
    2. bot name
        "username": "new"
channel name
    "channel": "#other_channel"
    "channel": "@someone"   direct message


example
    curl -X POST --data-urlencode 'payload={"channel": "#alert", "username": "webhookbot", "text": "This is posted to #alert and comes from a bot named webhookbot.", "icon_emoji": ":ghost:"}' https://hooks.slack.com/services/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

attachment
    payload
        attachments: list
            fallback
            pretext
            color
                fields
                    title
                    value
                    short
            
            
```



