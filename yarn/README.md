Hadoop Yarn dockerized
====

This is a set of scripts to create a full Hadoop Yarn cluster, each node inside a docker container.

Usage
---
Run the script cluster/cluster.sh passing the number of slaves: 


```
./cluster.sh 3
```

After the container creation the script will print the master ip address.

http://master:50070 for the hdfs console
http://master: 8088 for the YARN UI


Details
---

Each container is based on fedora 21, java 1.8 and runs both the Nodemanager and the Datanode processes; 
the master container runs the Nodemanager, Namenode and Secondary namenode. Each node also contains an
Infinispan server instance
