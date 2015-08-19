/etc/ssh/sshd_config:
    file.managed:
        - user: root
        - group: root
        - mode: 0600
        - source: salt://files/sshd_config

sshd:
    service.running:
        - enable: True
        - reload: True
        - watch:
            - file: /etc/ssh/sshd_config
