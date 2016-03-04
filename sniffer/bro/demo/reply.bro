event http_reply(c: connection, version: string, code: count, reason: string)
    {
    if ( c$http$status_code == 403 )
        print fmt("%s, %s, %s, %s", c$id$resp_h, version, code, reason);
    }
