#!/bin/bash
cat << EOF > /etc/shadowsocks-rust/main-server.json
{
    "server":"0.0.0.0",
    "server_port":42423,
    "password":"$PASS",
    "method":"$METHOD",
    "plugin":"simple-plugin",
    "plugin_opts":"server;path=$V2_PATH"
}
EOF
sed -e "s/\${PORT}/${PORT}/g" \
    -e "s|\${V2_PATH}|${V2_PATH}|g" \
    -i /data/nginx.conf
# cat /etc/shadowsocks/main-server.json
# cat /data/nginx.conf
ssserver-rust -c /etc/shadowsocks-rust/main-server.json &
cd /data
nginx -c nginx.conf -p $PWD
