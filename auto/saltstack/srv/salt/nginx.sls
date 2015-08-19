nginx:
    pkg:
        - installed

/etc/nginx/nginx.conf:
    file.managed:
        - user: nginx
        - group: nginx
        - mode: 0644
        - source: salt://files/nginx.conf

/etc/nginx/conf.d/default.conf:
    file.managed:
        - user: root
        - group: root
        - mode: 0644
        - source: salt://files/nginx_default.conf
