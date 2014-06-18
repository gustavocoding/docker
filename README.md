Hadoop dockerized
====

This is a set of scripts to create a Hadoop 1.1.1 cluster, each node inside a docker container.

Requirements
---

Docker 1.0
sshpass (yum install sshpass)

Usage
---
Edit script cluster.sh in the cluster folder, set the $N variable with the desired number of nodes. After a minute or so, 
take not of the ip address of the hadoop master and point the browser to 

http://master:50030 for the jobtracker console
http://master:50070 for the namenode console

All container are accessible via SSH, root password is 'root'
