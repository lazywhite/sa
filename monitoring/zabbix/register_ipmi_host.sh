#! /bin/sh
#
# register_ipmi_host.sh
# Copyright (C) 2017 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.
#


cat ip_list|while read IP;do
    curl -XPOST -H "Content-Type: application/json" -d "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"host.create\",
        \"params\": {
            \"host\": \"$IP\",
            \"interfaces\": [
                {
                    \"type\": 3,
                    \"main\": 1, #是否为main interface
                    \"useip\": 1,
                    \"ip\": \"$IP\",
                    \"dns\": \"\",
                    \"port\": \"623\"
                }
            ],
            \"groups\": [
                {
                    \"groupid\": \"25\"
                }
            ],
            \"templates\": [
                {
                    \"templateid\": \"10446\"
                }
            ]
        },
        \"auth\": \"e29ef973a6370e6d5ef9afc4aa1fc8a2\",
        \"id\": 12
    }" http://192.168.3.77/zabbix/api_jsonrpc.php
done

