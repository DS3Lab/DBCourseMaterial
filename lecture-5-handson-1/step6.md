# Aggregations

Having seen how we can join tables to extract meaningful information out of a
database, we can use aggregation functions.

For this part of the tutorial, we use the database we imported in the
beginning:

`\c employee`{{execute}}

Let's see how that database looks like by printing the list of tables:

`\dt`{{execute}}

Now, let's see what we have in the employees table:

`SELECT * FROM employees;`{{execute}}

Let's count the number of employees present in our database and also find
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
HAVING COUNT(*) = 4;`{{execute}}

