## configuration
### 1. virtual.conf
```

server {
    listen       8000 default_server;
    autoindex on;
    disable_symlinks off;
    autoindex_exact_size off;
    autoindex_localtime on;
    charset utf-8;

   location /logs/bookcombined {
        alias  /home/tool/tomcat_book/logs;
    }
}

```

### 2. mime.ty
```
types {
  text/plain                            txt out log; ## logfile suffix
}

```
