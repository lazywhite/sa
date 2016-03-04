@load policy/frameworks/control/controllee
@load policy/misc/loaded-scripts.bro
redef Communication::listen_port = 48881/tcp;
redef Communication::nodes += {
       ["httpevent"] = [$host = 192.168.56.2, $events = /Control::net_stats_request|update_logconfig/, $connect=F, $ssl=F]
};
const ports = {
80/tcp,81/tcp,1080/tcp,3128/tcp,8000/tcp,8080/tcp,8888/tcp,9001/tcp,
};
redef likely_server_ports += { ports };


