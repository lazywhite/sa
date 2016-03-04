@load frameworks/communication/listen;

global ping_log = open_log_file("ping");

redef Communication::nodes += {
    ["broping"] = [$host = 127.0.0.1, $events = /ping/,
                   $connect=F, $retry = 60 secs, $ssl=F]
};

event ping(src_time: time, seq: count) {
    event pong(src_time, current_time(), seq);
}

event pong(src_time: time, dst_time: time, seq: count) {
    print ping_log,
          fmt("ping received, seq %d, %f at src, %f at dest, one-way: %f",
              seq, src_time, dst_time, dst_time-src_time);
}
