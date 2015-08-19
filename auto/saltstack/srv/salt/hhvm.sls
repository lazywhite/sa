/etc/init.d/hhvm:
    file.managed:
        - user: root
        - group: root
        - mode: 0755
        - source: salt://files/hhvm

/etc/hhvm/server.hdf:
    file.managed:
        - user: root
        - group: root
        - mode: 0644
        - source: salt://files/server.hdf
