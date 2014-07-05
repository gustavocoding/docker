runuser -l postgres -c "initdb -D /var/lib/pgsql/data/"
runuser -l postgres -c "pg_ctl -D /var/lib/pgsql/data/ -l logfile start"
sleep 5
runuser -l postgres -c "createuser -h 127.0.0.1 -p 5432 -U postgres -S -D -R rhqadmin"
runuser -l postgres -c "createdb -h 127.0.0.1 -p 5432 -U postgres -O rhqadmin rhq"

sed -i -e 's/jboss.bind.address=/jboss.bind.address=0.0.0.0/' /rhq-server-4.11.0/bin/rhq-server.properties
/rhq-server-4.11.0/bin/rhqctl install --start

sed -i -e 's/c1de208601a7/localhost/g' /rhq-server-4.11.0/rhq-storage/conf/*
sed -i -e 's/c1de208601a7/localhost/g' /rhq-server-4.11.0/bin/*.properties

echo "Waiting for server to initialize"
IP=$(/sbin/ifconfig  | grep inet | xargs  | awk '{print $2}')

until $(curl --silent -L http://$IP:7080/coregui/login | grep -i Welcome > /dev/null )
do
   printf '.'
   sleep 5
done
echo "done."

/rhq-server-4.11.0/bin/rhqctl stop 
runuser -l postgres -c "pg_ctl -m fast stop"

