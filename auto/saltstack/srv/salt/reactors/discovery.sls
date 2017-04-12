{% if 'data' in data %}  {# check if proxied by syndic #}
{% if data['data']['act'] == "accept" and data['data']['result'] == True %}
register_host:
    runner.discovery.register:
        - mid: {{data['data']['id']}}
{% endif %}
{% else %}
{% if data['act'] == "accept" and data['result'] == True %}
register_host:
    runner.discovery.register:
        - mid: {{data['id']}}
{% endif %}
{% endif %}
