# Inserting data

In this part of the session, we will see how to insert data in our database
instance. Let's start the client, create a database, and connect to it:

`pgcli.sh -h postgres-server -u postgres`{{execute}}

`CREATE DATABASE testdatabase;`{{execute}}

`\c testdatabase`{{execute}}

Now we create a table called `employees`.

`CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      CHAR(1)         NOT NULL DEFAULT '?',
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);`{{execute}}

We first validate that the table is empty:

`SELECT * FROM employees;`{{execute}}

And then we insert some data.

Without columns as parameters:
`INSERT INTO employees
VALUES (10001, '1980-10-02', 'Ce', 'Zhang', 'M', '2016-01-01');`{{execute}}

With columns as parameters:
`INSERT INTO employees
       (emp_no, birth_date,   first_name, last_name, gender, hire_date)
VALUES (10002,  '1980-10-02', 'Gustavo',  'Alonso',  'M',    '2016-01-01');`{{execute}}

With `NULL` values:
`INSERT INTO employees
       (emp_no, first_name, last_name, gender, hire_date)
VALUES (10003,  'Ingo',     'Mueller', 'M',    '2016-01-01');`{{execute}}

Now the data are inside the table.

`SELECT * FROM employees;`{{execute}}

Based on the table schema, there are restrictions in the data that we can insert.
Some examples are:

Primary key non-duplicates:

`INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');`{{execute}}

Wrong types:

`INSERT INTO employees
VALUES ('asdf', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');`{{execute}}

`INSERT INTO employees
VALUES (10004, 'hello', 'Georgi', 'Facello', 'M', '1986-06-26');`{{execute}}

`INSERT INTO employees
VALUES (10004, '1953-09-02', 'Georgi', 'Facello', 'MM', '1986-06-26');`{{execute}}

Missing values:

`INSERT INTO employees
       (emp_no, birth_date,   last_name, gender, hire_date)
VALUES (10004,  '1953-09-02', 'Facello', 'M',    '1986-06-26');`{{execute}}

But missing values can sometimes (when?) work:

`INSERT INTO employees
       (emp_no, birth_date,  first_name, last_name, hire_date)
VALUES (10004,  '1953-09-02', 'Georgi',  'Facello', '1986-06-26');`{{execute}}
