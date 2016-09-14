#!/bin/bash
#########################################################################
# File Name: shadowsocks-libev-server.sh
# Version:1.0.20160914
# Created Time: 2016-09-14
#########################################################################

set -e
set -- ss-server "$@"
SS_SERVER_ADDR=${SS_SERVER_ADDR:-0.0.0.0}                     #"server": "0.0.0.0",
SS_SERVER_PORT=${SS_SERVER_PORT:-8388}                        #"server_port": 8388,
SS_PASSWORD=${SS_PASSWORD:-password}                          #"password":"password",
SS_METHOD=${SS_METHOD:-aes-256-cfb}                           #"method":"aes-256-cfb",
SS_TIMEOUT=${SS_TIMEOUT:-600}                                 #"timeout":600,
SS_DNS_ADDR=${SS_DNS_ADDR:-8.8.8.8}                           #-d "8.8.8.8",
SS_UDP=${SS_UDP:-true}                                        #-u support,
SS_ONETIME_AUTH=${SS_ONETIME_AUTH:-true}                      #-A support,
SS_FAST_OPEN=${SS_FAST_OPEN:-true}                            #--fast-open support,
SS_CONF="/usr/local/conf/ss_config.json"
[ ! -f ${SS_CONF} ] && cat > ${SS_CONF}<<-EOF
{
    "server":"${SS_SERVER_ADDR}",
    "server_port":${SS_SERVER_PORT},
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"${SS_PASSWORD}",
    "timeout":${SS_TIMEOUT},
    "method":"${SS_METHOD}"
}
EOF
if [[ "${SS_UDP}" =~ ^[Tt][Rr][Uu][Ee]|[Yy][Ee][Ss]|1|[Ee][Nn][Aa][Bb][Ll][Ee]$ ]]; then
    SS_UDP_FLAG="-u "
else
    SS_UDP_FLAG=""
fi
if [[ "${SS_ONETIME_AUTH}" =~ ^[Tt][Rr][Uu][Ee]|[Yy][Ee][Ss]|1|[Ee][Nn][Aa][Bb][Ll][Ee]$ ]]; then
    SS_ONETIME_AUTH_FLAG="-A "
else
    SS_ONETIME_AUTH_FLAG=""
fi
if [[ "${SS_FAST_OPEN}" =~ ^[Tt][Rr][Uu][Ee]|[Yy][Ee][Ss]|1|[Ee][Nn][Aa][Bb][Ll][Ee]$ ]]; then
    SS_FAST_OPEN_FLAG="--fast-open"
else
    SS_FAST_OPEN_FLAG=""
fi
echo "+-------------------------------------------------+"
echo "|          Manager for Shadowsocks-libev          |"
echo "+-------------------------------------------------+"
echo "|        Intro: https://github.com/cndocker       |"
echo "+-------------------------------------------------+"
echo "|    Images: cndocker/shadowsocks-libev:latest    |"
echo "+-------------------------------------------------+"
echo ""
echo "Starting Shadowsocks-libev..."
exec "${@}" -c ${SS_CONF} -d "${SS_DNS_ADDR}" ${SS_UDP_FLAG}${SS_ONETIME_AUTH_FLAG}${SS_FAST_OPEN_FLAG}

