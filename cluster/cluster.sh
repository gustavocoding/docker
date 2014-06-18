#!/bin/bash
set -e

N=2

function run()
{
  echo "$(docker run -i -t -d  gustavonalle/hadoop-base)"
}

function ip()
{
  echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)" 
}

function exec_cmd()
{
  sshpass -p "root" ssh -o StrictHostKeyChecking=no root@$1 $2 
}

function copy_keys()
{
  exec_cmd $1 "mkdir -p /root/.ssh/ &&  /bin/cp -r /home/hadoop/.ssh/* /root/.ssh/"
}

function replace_hosts()
{
  exec_cmd $1 "sed -i 's/c1de208601a7/$IP_MASTER/g' /opt/hadoop/hadoop-1.1.1/conf/*.xml" 
}

function set_master()
{
  exec_cmd $1 "echo '$2' > /opt/hadoop/hadoop-1.1.1/conf/masters"
}

function add_slave()
{
  exec_cmd $1 "echo '$2' >> /opt/hadoop/hadoop-1.1.1/conf/slaves"
}

function remove_slaves() 
{
 exec_cmd $1 "> /opt/hadoop/hadoop-1.1.1/conf/slaves"
}


IDMASTER=$(run)
sleep 10 

IP_MASTER=$(ip $IDMASTER)
copy_keys $IP_MASTER
replace_hosts $IP_MASTER
set_master $IP_MASTER $IP_MASTER
remove_slaves $IP_MASTER

START=1
for (( c=$START; c<=$N; c++)) 
do
 IDSLAVE=$(run) 
 sleep 10 
 IP_SLAVE=$(ip $IDSLAVE)
 replace_hosts $IP_SLAVE
 set_master $IP_SLAVE $IP_MASTER
 echo -n "Slave $IP_SLAVE configured"
 add_slave $IP_MASTER $IP_SLAVE
done

echo "Starting process"
exec_cmd $IP_MASTER "/etc/init.d/hadoop-master start"  
exec_cmd $IP_MASTER "/etc/init.d/hadoop-jobtracker start"  

echo -n "Cluster started. Master is $IP_MASTER"
