#!/bin/bash
set -ex

ACCESS_LOG=/var/log/h2o/access.log

if [ -f /var/lib/mysql/mysqld-slow.log ]; then
    sudo mv /var/lib/mysql/mysqld-slow.log /var/lib/mysql/mysqld-slow.log.$(date "+%Y%m%d_%H%M%S")
fi

if [ -f ${ACCESS_LOG} ]; then
    sudo mv ${ACCESS_LOG} ${ACCESS_LOG}.$(date "+%Y%m%d_%H%M%S")
fi
sudo systemctl restart mariadb
sudo systemctl restart torb.go
sudo systemctl restart h2o

/home/isucon/torb/bench/bin/bench -data=/home/isucon/torb/bench/data -remotes=localhost -output=result.json
