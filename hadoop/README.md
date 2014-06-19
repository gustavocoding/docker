Hadoop dockerized
====

This is a set of scripts to create a Hadoop 1.1.1 cluster, each node inside a docker container.

Requirements
---

Docker 1.0

sshpass (yum install sshpass)

Usage
---
Run the script cluster/cluster.sh. To change the number of slave nodes, set the N variable inside.

After the constainer creation the script will print the master ip address.

http://master:50030 for the jobtracker console
http://master:50070 for the namenode console

All containers are accessible via SSH, root password is 'root'

Details
---

Each container is based on fedora, java 1.7 and runs both the Tasktracker and the Datanode processes; 
the master container runs the Jobtracker, Namenode and Secondary namenode
