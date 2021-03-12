[![](http://shields.katacoda.com/katacoda/eth-dmdb/count.svg)](https://www.katacoda.com/eth-dmdb "See tutorials on Katacoda.com")

# Data Modeling and Databases (DMDB)

This repository hosts public course material for the [Data Modeling and Databases](https://ds3lab.inf.ethz.ch/dmdb2021.html) course at ETH given by Prof. Ce Zhang. The main purpose is to host the interactive tutorials on [Katacoda](https://ds3lab.inf.ethz.ch/dmdb2021.html).

## Alternatives to Katacoda

### Docker

Prerequisites:

* [Docker](https://docs.docker.com/get-docker/)

Start a Postgres server:

```bash
docker run -d \
    -p 5432:5432 \
    -v /:/host/:ro \
    --name postgres-server \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    postgres:13.2-alpine
```

Nothing else should be required. This launches a docker container in the
background. You can see the running containers with the following command:

```bash
docker ps
```

The container you just run should show up in the output (called
`postgres-server`). You can now stop and start that container with the
following commands:

```bash
docker stop postgres-server
docker start postgres-server
```

This should preserve the databases you have created inside the container. If
you want to remove it completely (including the databases), use the following:

```bash
docker rm postgres-server
```

You can run the standard Postgres command line client inside that container
like this (setting the user to `postgres`):

```bash
docker exec -it postgres-server psql -U postgres
```

The same way, you can start a shell inside that container:

```bash
docker exec -it postgres-server psql -U bash
```

To use [`pgcli`](https://www.pgcli.com/) instead, run the following:

```bash
docker run --rm -it \
    --link postgres-server \
    -v /:/host/:ro \
    -v $HOME/.config/pgcli/:/root/.config/pgcli/ \
    ds3lab/pgcli -h postgres-server -U postgres
```

Both containers are run such that the entire host file system is available
(read-only) under `/host/` inside of the containers. If you need to import
files inside the containers, access the files accordingly. Also, for `pgcli`,
the config folder of your home directory is mounted into the container such
that the configuration and command history is shared with the host.

### `pgcli` via `pip`

Prerequisites:

* [Python](https://www.python.org/downloads/) with `pip`

You may also be able to install [`pgcli`](https://www.pgcli.com/) on your own
machine. Normally, the following is enough:

```bash
pip3 install pgcli
```

However, you need a basic compiler infrastructure and the Postgres client
library installed. On Debian, Ubuntu, etc, the following may do that:

```bash
sudo apt install build-essential libpq-dev
```

Alternatively, you may be lucky with installing an old version:

```bash
pip install pgcli==2.1.1 --only-binary psycopg2
```
