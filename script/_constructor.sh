#!/bin/bash
path=$(dirname $(dirname $(readlink -f "$0")))
echo $path
SERVER_INFO="$path/settings/server.txt"
inhost=$1
# set user [lindex $argv 1]
# set port [lindex $argv 2]
# set passwd [lindex $argv 3]
# set name [lindex $argv 4]
# set upasswd [lindex $argv 5]

for host in $(awk '{print $1}' $SERVER_INFO)
do
    port=$(awk -v I="$host" 'I==$1{print $2}' $SERVER_INFO)
    desc=$(awk -v I="$host" 'I==$1{print $3}' $SERVER_INFO)

    if [ "$inhost" == "$host" ]; then
        sh "$path/script/_selector.sh" $host $port $desc
        exit 1
    fi
done
echo "未检索到配置"
