# Populating and exploring the database

Finally, let's populate the database for later:

`./populate.sh`{{execute}}

Then, connect to the server using either client:

`psql.sh -U postgres`{{execute}} 
`pgcli.sh -h postgres-server -u postgres`{{execute}}

and connect to the discogs database:

`\c discogs`{{execute}}

### Exploring the populated database

In postgres, we can list all the tables in a database using

`\dt`{{execute}}

or by using the Postgres metatable:

`SELECT * FROM pg_catalog.pg_tables WHERE schemaname = 'public';`{{execute}}

We can look up the schema of any individual table via:

`\d artists`{{execute}}

or simply by looking at some of the tuples in the table:

`SELECT * FROM artists LIMIT 10;`{{execute}}

We can also find the number of rows in the table:

`SELECT COUNT(*) FROM artists;`{{execute}}

Use your preferred method to explore the schemas of the remaining 3 tables.