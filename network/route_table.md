## mac 
sudo route -n <action> -net 10.67.0.0/16 192.168.120.254
-prefixlen 24
-netmask 255.255.255.0
-gateway  192.168.120.254
-link en0

add         Add a route.
flush       Remove all routes.
delete      Delete a specific route.
change      Change aspects of a route (such as its gateway).
get         Lookup and display the route for a destination.
monitor


## linux
route -n <action> -net 10.67.0.0/16 gw 192.168.120.254
