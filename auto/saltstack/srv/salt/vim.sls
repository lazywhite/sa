vim-enhanced:
    pkg:
        - installed

/etc/vimrc:
    file.managed:
        - user: root
        - group: root
        - mode: 0644
        - source: salt://files/vimrc
