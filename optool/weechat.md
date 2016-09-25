## Usage
```
/server add freenode chat.freenode.net
/set irc.server.freenode.autoconnect on

/set irc.server.freenode.nicks "cppking"
/set irc.server.freenode.username "cppking"


/connect freenode
/msg NickServ identify <password>

/join <channel>

```
## Configure
```
.weechat/irc.conf
    freenode.addresses = "chat.freenode.net"
    freenode.nicks = "cppking"
    freenode.username = "cppking"
    freenode.password = "10101010"
```
    
