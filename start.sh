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
    "plugin_opts":"server;path=$SS_PATH"
}
EOF
sed -e "s/\${PORT}/${PORT}/g" \
    -e "s|\${SS_PATH}|${SS_PATH}|g" \
    -i /data/nginx.conf
# cat /etc/shadowsocks/main-server.json
# cat /data/nginx.conf
ss-server -c /etc/shadowsocks/main-server.json &
cd /data
nginx -c nginx.conf -p $PWD
