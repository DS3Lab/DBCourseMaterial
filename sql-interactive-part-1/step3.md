# Statements using SELECT

Now that we have data in our table let's do simple projections using `SELECT`.

Simple projection:

`SELECT first_name, last_name FROM employees;`{{execute}}

Column renaming:

`SELECT first_name AS fn, last_name AS ln FROM employees;`{{execute}}

Select constants:

`SELECT 'Hello', first_name, last_name FROM employees;`{{execute}}

Select a column several times:

`SELECT emp_no, emp_no FROM employees;`{{execute}}

Select a column several times and rename every instance:

`SELECT emp_no AS no1, emp_no AS no2 FROM employees;`{{execute}}

Use expressions:

`SELECT emp_no AS no1, emp_no * 2 AS no2 FROM employees;`{{execute}}

Use anonymous expressions:
`SELECT emp_no AS no1, emp_no * 2 AS no2, emp_no + emp_no FROM employees;`{{execute}}

Use functions:

`SELECT first_name || ' ' || last_name FROM employees;`{{execute}}

`SELECT first_name || ' ' || last_name AS name FROM employees;`{{execute}}

Use special expressions for dates:

`SELECT birth_date, birth_date + 5 FROM employees;`{{execute}}

Use special functions for dates:

`SELECT AGE(birth_date) FROM employees;`{{execute}}
