# Installing Postgres

We will follow again the steps from last time to install a Postgres instance.

Run the following commands in your katakoda interactive environment to install Postgres.

`apt-get install wget ca-certificates`{{execute}}

`wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -`{{execute}}

``sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'``{{execute}}

`apt-get update`{{execute}}

`apt-get install -y postgresql postgresql-contrib`{{execute}}

Now that Postgres is install create a running instance and connect to the database.

`pg_ctlcluster 12 main start`{{execute}}

`su - postgres`{{execute}}

`psql`{{execute}}

Now that we are connected to the database let's create and connect to a test
database to run our queries.

`CREATE DATABASE testdatabase;`{{execute}}

`\c testdatabase`{{execute}}

Everything is set up, so let's get started!
