#!/bin/bash
set -e

N=${1:-2}
CUR_DIR="$PWD"

function run()
{
  echo "$(docker run -v $CUR_DIR:/usr/local/sample -d -it --name $1 gustavonalle/flink)"
}

function ip()
{
  echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)" 
}

function exec_cmd()
{
  $(docker exec -it $*)
}

function replace_hosts()
{
  exec_cmd $1 "sed -i s/localhost/$IP_MASTER/g /usr/local/flink/conf/flink-conf.yaml"
}

function add_slave()
{
  docker exec -it $1 sh -c "echo $2 >> /usr/local/flink/conf/slaves"
}

function remove_slaves() 
{
 exec_cmd $1 "truncate -s 0 /usr/local/flink/conf/slaves"
}

echo "Creating a cluster of $N slaves"
#docker run -d --hostname resolvable -v /var/run/docker.sock:/tmp/docker.sock -v /etc/resolv.conf:/tmp/resolv.conf mgood/resolvable

IDMASTER=$(run flink-master)

IP_MASTER=$(ip $IDMASTER)

echo "Master created, ip address is $IP_MASTER"

replace_hosts flink-master
remove_slaves flink-master

START=1
for (( c=$START; c<=$N; c++)) 
do
 IDSLAVE=$(run flink-slave$c) 
 replace_hosts flink-slave$c 
 echo  "Slave flink-slave$c configured"
 IP_SLAVE=$(ip $IDSLAVE)
 add_slave flink-master $IP_SLAVE
done

sleep 5

echo "Starting cluster"
docker exec  flink-master /usr/local/flink/bin/start-cluster.sh

echo "Cluster started. Dashboard on http://$IP_MASTER:8081/"
