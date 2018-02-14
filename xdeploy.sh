#!/bin/bash

usage()
{
    cat << EOF
usage: 
    $(basename $0) -h <host> [-p <port>] -d <server-id> [-s]

options:
    -h <host>        tomcat host ip or host name
    -p <port>        tomcat port, [Default: 8080]
    -d <server-id>   tomcat server id in ~/.m2/settings.xml
    -s               HTTPS
EOF
    exit 1
}

https=no

while getopts ':h:p:d:s' OPTION; do
    case $OPTION in
        h)
            host=$OPTARG
            ;;
        p)
            port=$OPTARG
            ;;
        d)
            server_id=$OPTARG
            ;;
        s)
            https=yes
            ;;
        \?)
            usage
            ;;
    esac
done

[ $# -eq 0 ] && usage

if [ -z "$port" ]; then
    if [ $https = 'yes' ]; then
        port=443
    else
        port=8080
    fi
fi

scheme=http
[ $https = 'yes' ] && scheme=https

domain=$host:$port
[ $scheme = 'http' -a $port -eq 80 ] && domain=$host
[ $scheme = 'https' -a $port -eq 443 ] && domain=$host

# tomcat 7+
upload_url="$scheme://$domain/manager/text"

mvn tomcat7:undeploy tomcat7:deploy-only -Dmaven.test.skip=true -Dtomcat.url="$upload_url" -Dtomcat.server="$server_id"

