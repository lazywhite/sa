/var/www/hrcf/app/config/local/database.php:
    file.managed:
        - user: nginx
        - group: nginx
        - mode: 0644
        - source: salt://files/database.php

/var/www/hrcf/bootstrap/start.php:
    file.managed:
        - user: nginx
        - group: nginx
        - mode: 0644
        - source: salt://files/start.php.tpl
        - template: jinja
