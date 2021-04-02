#!/usr/bin/env bash

docker exec -it postgres-server psql -U postgres "$@"