## redirect http to https
```
frontend http
        bind *:80
        redirect scheme https if !{ ssl_fc }
        acl host_console hdr(host) -i console.nextpaas.com
        use_backend console.nextpaas.com if host_console

# redirect specific domain name
# redirect scheme https if { hdr(Host) -i www.mydomain.com } !{ ssl_fc }
```
