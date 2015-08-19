/root/test:
    file.managed:
        - source: salt://test.tpl
        - template: jinja
