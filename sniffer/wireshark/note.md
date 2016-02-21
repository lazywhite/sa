##note 
tshark can compile with pf_ring

##packet capture filter
### ip filter
### protocol filter
### port filter


## commands
```
tshark -i wlan0 -w capture-output.pcap
tshark -r capture-output.pcap
```

tshark -i en0 -f "tcp port 80 or tcp port 8080 or tcp port 443 or tcp port 8443" -n  -Y "http.request or http.response"  -T fields -Eseparator="/t" -e http -e http.request -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport -e http.request.method  -e http.host -e http.request.uri -e http.request.full_uri -e http.user_agent -e http.content_length -e http.content_type -e http.response.code -e http.response.phrase -e http.content_encoding -e http.cookie -e http.set_cookie -e data.data -e text


tshark -i en0 -o "ssl.desegment_ssl_records:TRUE" -o "ssl.desegment_ssl_application_data:TRUE" -o "ssl.keys_list:11.111.111.111,150000,http,charles.pem" -o "ssl.debug_file:ssldebug.log" -f 'host 172.16.0.81 and host 172.16.0.98' -n -Y "http.request or http.response"  -T fields -Eseparator="/t" -e http -e http.request -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport -e http.request.method  -e http.host -e http.request.uri -e http.request.full_uri -e http.user_agent -e http.content_length -e http.content_type -e http.response.code -e http.response.phrase -e http.content_encoding -e http.cookie -e http.set_cookie -e data.data -e text


 tshark -i en0 -o "ssl.desegment_ssl_records:TRUE"   -o "ssl.desegment_ssl_application_data:TRUE" -o "ssl.keys_list:11.111.111.111,150000,http,charles.pem" -o "ssl.debug_file:ssldebug.log" -f 'host 172.16.0.98' -n 
