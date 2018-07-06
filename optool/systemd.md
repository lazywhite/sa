systemctl daemon-reload
journalctl -xe
journalctl -f -u kubelet.service
