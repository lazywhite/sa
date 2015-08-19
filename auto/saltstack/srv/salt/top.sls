base:
    '*':
        - vim
        - sshd

    'web*':
        - nginx
        - php55
        - hhvm
        - hrcf

    'db*':
        - maria
