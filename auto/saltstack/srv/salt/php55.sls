/etc/php.ini:
    file.managed:
        - user: root
        - group: root
        - mode: 0644
        - source: salt://files/php.ini
    

/etc/php-fpm.d/www.conf:
    file.managed:
        - user: root
        - group: root
        - mode: 0644
        - source: salt://files/php-fpm-www.conf
