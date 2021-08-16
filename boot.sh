#!/bin/bash

# Start the first process
container_dir="/data/"

env > /etc/.cronenv

mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.example
cat /etc/mysql/mariadb.conf.d/50-server.cnf.example | grep -v 'bind-address' > /etc/mysql/mariadb.conf.d/50-server.cnf
echo "bind-address            = *" >> /etc/mysql/mariadb.conf.d/50-server.cnf
mv /var/lib/mysql /var/lib/mysql-container
mv /var/lib/mysql-files /var/lib/mysql-files-container
ln -s /data/mysql/ /var/lib/mysql
ln -s /data/mysql-files /var/lib/mysql-files

if [ -e "$container_dir/dockercron" ]
then
   echo "Cron Exists"
   mv /etc/cron.d/dockercron /etc/cron.d/dockercron-docker
   ln -s  $container_dir/dockercron /etc/cron.d/dockercron
else
   echo "Using default cron"
fi

# cron
service cron start &
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start cron: $status"
    exit $status
fi

# Start the second process
service mysql start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start mysql: $status"
  exit $status
fi
bash

