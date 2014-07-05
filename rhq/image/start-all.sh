runuser -l postgres -c "pg_ctl -D /var/lib/pgsql/data/ -l logfile start"
/rhq-server-4.11.0/bin/rhqctl start
