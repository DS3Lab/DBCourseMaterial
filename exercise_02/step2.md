#### Create and Populate Databases

Let's run a script which creates and populates the necessary databases (on the Postgres server running in our docker image).

`populate.sh`{{execute}}

Then, connect to the database using either client:

`psql.sh -U postgres`{{execute}}
`pgcli.sh -h postgres-server -u postgres`{{execute}}

Now we are connected to our DBMS, we can use the following command to *list* all existing database instances:

``\l``{{execute}}

In addition to three default database instances, we should be able to see our test database, and the three database instances that will be used for the exercise: **employee**, **tpch**, and **zvv**. 