#!/usr/bin/env bash

CONTAINER_NAME=postgres-server

# Start new server it not exists
if ! docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME > /dev/null 2>&1
then
    docker run -d \
        -p 5432:5432 \
        -v "$PWD":/data \
        --name $CONTAINER_NAME \
        -e POSTGRES_HOST_AUTH_METHOD=trust \
        postgres:13.2-alpine
# Restart if exited
elif [[ "$(docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME)" == "exited" ]]
then
    docker start $CONTAINER_NAME
# Raise error if not running
elif [[ "$(docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME)" != "running" ]]
then
    echo "docker container $CONTAINER_NAME in unexpected state."
    exit 1
fi