##
```
#export Charles root certificate and private key in pkcs12 format .p12
#use password to protect
brew install nss --> pk12util
#generate private key
openssl pkcs12 -in tomcat.p12 -nocerts -nodes -out clearkey.pem
```

1. setup charles proxy 
2. use tshark to decrypt ssl and output to pcap file
3. use tcpReplay 
