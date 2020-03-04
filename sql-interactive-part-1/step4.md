# INSERT statements using SELECT

Now that we have seen how we can write simple INSERT and SELECT statements let's
create other tables and fill them with values with INSERT statements that
contain SELECT statements.

First, let's create a table called `departments` and verify that it contains no
data.

`CREATE TABLE departments (
    dept_no     INT             NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no)
);`{{execute}}

`SELECT * FROM departments;`

Now, let's insert some values using the syntax we already know:

`INSERT INTO departments VALUES (1, 'Sales');`{{execute}}

`INSERT INTO departments (dept_name, dept_no) VALUES ('Human Resources', 2);`{{execute}}

`INSERT INTO departments VALUES (3, 'Marketing'), (4, 'Legal');`{{execute}}

Another way to insert rows into a table is by using the SELECT statement:

`INSERT INTO departments
    SELECT 5, 'Development';`{{execute}}

Let's verify that all our data have been inserted in the database:

`SELECT * FROM departments;`{{execute}}

Now that we have the `employees` and `departments` tables, we will create the
`dept_emp` table, which connects them.

`CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    PRIMARY KEY (emp_no, dept_no, from_date)
);`

Again, we verify that the table contains no rows:

`SELECT * FROM dept_emp;`

And then we connect every employee with a department:

`INSERT INTO dept_emp
    SELECT emp_no, 5 AS dept_no, NOW(), '9999-01-01' FROM employees;`{{execute}}

Let's verify that we have inserted everything correctly:

`SELECT * FROM dept_emp;`{{execute}}

Like the previous INSERT statements, some of the restrictions that we
encountered before still apply.

Primary key non-duplicates:
`INSERT INTO dept_emp
    SELECT emp_no, 5 AS dept_no, NOW(), '9999-01-01' FROM employees;`{{execute}}

However, we can change one of the three attributes and then our inserts are
valid:
`INSERT INTO dept_emp
    SELECT emp_no, 5 AS dept_no, '1999-01-01', NOW() FROM employees;`

And finally since we do not have the notion of foreign keys (yet!), we can
insert non-existing employees/departments.

`INSERT INTO dept_emp VALUES (10001, 6, '1980-01-01', '1999-01-01');`{{execute}}
