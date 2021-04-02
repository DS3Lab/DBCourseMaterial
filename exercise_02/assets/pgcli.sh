#!/usr/bin/env bash

docker run --rm -it \
    --link postgres-server \
    ingomuellernet/pgcli "$@"