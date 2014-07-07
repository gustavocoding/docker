#!/bin/bash

IMAGE=gustavonalle/rhq-411-server

function run()
{
  echo "$(docker run -i -t -d  $IMAGE)"
}

function ip()
{
  echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)" 
}

echo "Pulling image"
docker pull $IMAGE 

echo "Launching container"

ID=$(run)

IP=$(ip $ID)

echo "Container launched, ip address is $IP"
