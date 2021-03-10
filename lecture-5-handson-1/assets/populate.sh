#!/usr/bin/env bash

docker cp $HOME/employee.zip postgres-server:/var/lib/postgresql/employee.zip
docker exec --workdir /var/lib/postgresql postgres-server unzip employee.zip

echo "Create and populate 'employee' database."
docker exec postgres-server sh -c 'psql -U postgres -c "CREATE DATABASE employee;"'
docker exec postgres-server sh -c "psql -U postgres employee < /var/lib/postgresql/employee/schema.sql"
docker exec postgres-server sh -c "psql -U postgres -d employee -f /var/lib/postgresql/employee/inserts.sql"
