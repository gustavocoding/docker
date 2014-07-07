#!/bin/bash

function run()
{
  echo "$(docker run -i -t -d  gustavonalle/rhq-server)"
}

function ip()
{
  echo "$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)" 
}

echo "Launching container"

ID=$(run)

IP=$(ip $ID)

echo "Container launched, ip address is $IP"
