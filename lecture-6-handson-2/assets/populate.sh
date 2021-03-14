#!/usr/bin/env bash

docker exec --workdir /var/lib/postgresql postgres-server wget -O discogs.zip https://cloud.inf.ethz.ch/s/PWRFqmNczEkYS7M/download
docker exec --workdir /var/lib/postgresql postgres-server unzip discogs.zip

echo "Create and populate 'discogs' database."
docker cp ~/inserts.sql postgres-server:/var/lib/postgresql/inserts.sql
docker exec postgres-server sh -c 'psql -U postgres -c "CREATE DATABASE discogs;"'
docker exec postgres-server sh -c "psql -U postgres discogs < /var/lib/postgresql/inserts.sql"
