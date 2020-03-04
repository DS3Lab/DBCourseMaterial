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

Now let's count the number of employees present in our database and also find
the maximum employee number::

`SELECT COUNT(*) FROM employees;`{{execute}}

`SELECT MAX(emp_no) FROM employees;`{{execute}}

However, some names occur several times, therefore to find the number of
distinct employees our database has we execute the following query:

`SELECT COUNT(DISTINCT last_name) FROM employees;`{{execute}}

And to find the distinct last names the following (only displaying the first 10:

`SELECT DISTINCT last_name FROM employees LIMIT 10;`{{execute}}

If we sort the last names we can actually see that `SELECT DISTINCT` actually
removes duplicates:

`SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;;`{{execute}}

We can also sort by different columns and in different directions:

`SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC, first_name DESC
LIMIT 10;`{{execute}}

Now let's find how often each last name occurs:

`SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
LIMIT 10;`{{execute}}

But better the most common names to be on top:

`SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC
LIMIT 10;`{{execute}}

To find any first_name per group we apply an aggregate function:
`SELECT MAX(first_name) last_name, COUNT(*) as c
FROM employees
GROUP BY last_name
ORDER BY c DESC
LIMIT 10;`{{execute}}

`SELECT (ARRAY_AGG(first_name))[1], last_name, COUNT(*) as c
FROM employees
GROUP BY last_name
ORDER BY c DESC
LIMIT 10;`{{execute}}

How to see the names occuring exactly 4 times?

`SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
-- WHERE? No, WHERE is done *before* the grouping!
HAVING COUNT(*) = 4;`{{execute}}

