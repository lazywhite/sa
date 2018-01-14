cat hostid_list|while read hostid;do
    curl -XPOST -H "Content-Type: application/json" -d "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"host.update\",
        \"params\": {
            \"hostid\": \"$hostid\",
            \"templates_clear\": [
                {
                    \"templateid\": \"10650\"
                }
            ]
        },
        \"auth\": \"16f6ca2be8bdafc77d4e07bbf45f9b50\",
        \"id\": 1
    }" http://127.0.0.1/zabbix/api_jsonrpc.php
done


