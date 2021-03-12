#!/usr/bin/env bash

docker run --rm -it \
    --link postgres-server \
    -v /root/.config/pgcli/:/root/.config/pgcli/ \
    ingomuellernet/pgcli "$@"
