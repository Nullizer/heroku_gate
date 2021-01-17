#!/bin/bash
mkdir /etc/shadowsocks
cat << EOF > /etc/shadowsocks/main-server.json
{
    "server":"0.0.0.0",
    "server_port":42423,
    "password":"$SS_PASS",
    "method":"aes-256-gcm",
    "fast_open":false,
    "mode":"tcp_and_udp",
    "plugin":"v2ray-plugin",
    "plugin_opts":"server;fast-open;path=$SS_PATH"
}
EOF
# ss-server -c /etc/shadowsocks/main-server.json
cd /data
nginx -c nginx.conf -p $PWD
