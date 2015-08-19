/etc/my.cnf.d/wsrep.cnf:
    file.managed:
        - user: mysql
        - group: mysql
        - mode: 0644
        - source: salt://files/wsrep.cnf.tpl
        - template: jinja

