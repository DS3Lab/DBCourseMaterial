# Aggregations

Having seen how we can join tables to extract meaningful information out of a
database, we can use aggregation functions.

We first delete all our data since we are going to import new.

`
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE dept_emp;`{{execute}}

We then type the exit command twice (once for getting out of the psql prompt
and once for being root again).

`exit`{{execute}}

`exit`{{execute}}

We then copy the data from the root home to the postgresql home:

`cp employee.zip /var/lib/postgresql/`{{execute}}

We login again as postgres:

`su - postgres`{{execute}}

We unzip the data folder:

`unzip employee.zip`{{execute}}

We connect to the postgres prompt:

`psql`{{execute}}

And our testdatabase:

`\c testdatabase`{{execute}}

We then import the schema of the tables:

`\i /var/lib/postgresql/employee/schema.sql`{{execute}}

And the actual data:
`\i /var/lib/postgresql/employee/inserts.sql`{{execute}}

