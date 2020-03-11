#!/bin/bash

apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt-get update
apt-get install -y postgresql postgresql-contrib
pg_ctlcluster 12 main start
wget https://www.systems.ethz.ch/sites/default/files/courses/2020-spring/dmdb/artists.zip
cp artists.zip /var/lib/postgresql/
unzip data.zip
