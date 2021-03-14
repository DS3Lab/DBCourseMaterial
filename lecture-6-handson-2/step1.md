# Installing Postgres

The tutorial should install and start a Postgres server automatically (inside
docker). Once the installation completes, we have two ways to connect to the
server. The first is the official client:

`psql.sh -U postgres`{{execute}}

Let's just confirm that we are indeed connected:

`\c`{{execute}}

Then quite the client again:

`exit`{{execute}}

The second is an inofficial client with a few nice features (inside docker as
well):

`pgcli.sh -h postgres-server -u postgres`{{execute}}

Confirm that we have a connection and quit again:

`\c`{{execute}}

`exit`{{execute}}

We have our client and server, let's get started!