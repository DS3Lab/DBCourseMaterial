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

`\copy employees FROM '/var/lib/postgresql/employee/data/employees.tbl' WITH delimiter AS '|';`{{execute}}

`\copy departments FROM '/var/lib/postgresql/employee/data/departments.tbl' WITH delimiter AS '|';`{{execute}}

`\copy dept_manager FROM '/var/lib/postgresql/employee/data/dept_manager.tbl' WITH delimiter AS '|';`{{execute}}

`\copy dept_emp FROM '/var/lib/postgresql/employee/data/dept_emp.tbl' WITH delimiter AS '|';`{{execute}}

`\copy titles FROM '/var/lib/postgresql/employee/data/titles.tbl' WITH delimiter AS '|';`{{execute}}

`\copy salaries FROM '/var/lib/postgresql/employee/data/salaries.tbl' WITH delimiter AS '|';`{{execute}}

Let's verify that we have data in our `employees` table again:

`SELECT * FROM employees;`{{execute}}
