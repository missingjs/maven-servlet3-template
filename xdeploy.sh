#!/bin/bash

usage()
{
    cat << EOF
usage: 
    $(basename $0) -h <host> [-p <port>] -d <server-id>

options:
    -h <host>        tomcat host ip or host name
    -p <port>        tomcat port, [Default: 8080]
    -d <server-id>   tomcat server id in ~/.m2/settings.xml
EOF
    exit 1
}

port=8080

while getopts ':h:p:d:' OPTION; do
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
        \?)
            usage
            ;;
    esac
done

[ $# -eq 0 ] && usage

# tomcat 7+
upload_url="http://$host:$port/manager/text"

mvn tomcat7:undeploy tomcat7:deploy-only -Dmaven.test.skip=true -Dtomcat.url="$upload_url" -Dtomcat.server="$server_id"

