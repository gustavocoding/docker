Apache Flink dockerized
====

This is a set of scripts to create a local multi-node Flink cluster, each node inside a docker container.

Quick start
---

To create a 3 node cluster, run:

```
bash <(curl -s https://raw.githubusercontent.com/gustavonalle/docker/master/flink/cluster.sh)
```


Usage
---
Run the script cluster.sh passing the number of slaves: 

```
./cluster.sh 3
```

Details
---
Each container is based on fedora 21, java 1.8 and uses Apache Flink standalone mode. 
The master container will run the jobmanager, and the other containers will run the taskmagers only.
