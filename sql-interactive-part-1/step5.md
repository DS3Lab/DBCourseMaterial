# Joins and join variants

Now that we have three tables connected among them we can perform joins to
extract some useful information from them.

We start by getting the data present in the tables:

`SELECT * FROM employees;`{{execute}}

`SELECT * FROM departments;`{{execute}}

`SELECT * FROM dept_emp;`{{execute}}

`SELECT * FROM employees, departments, dept_emp;`{{execute}}

The cartesian product contains a lot of redundant information, therefore it's
more beneficial to perform a join to only the matching rows. In the following
query we select the employees that work in some department:

`SELECT *
FROM employees, departments, dept_emp
WHERE employees.emp_no = dept_emp.emp_no
    AND dept_emp.dept_no = departments.dept_no;`{{execute}}

Still there is some redundancy in the above join. We can project on most
interesting columns:

`SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees, departments, dept_emp
WHERE employees.emp_no = dept_emp.emp_no
    AND dept_emp.dept_no = departments.dept_no;`{{execute}}

What went wrong and why the following query fixes the issue?

`SELECT employees.emp_no, first_name, last_name,
       departments.dept_no, dept_name,
       from_date, to_date
FROM employees, departments, dept_emp -- better :)
WHERE employees.emp_no = dept_emp.emp_no
    AND dept_emp.dept_no = departments.dept_no;`{{execute}}

The above query still returns too many records. Let's instead return only the
*current* `dept_emp` entries.

`SELECT employees.emp_no, first_name, last_name, departments.dept_no, dept_name, to_date
FROM employees, departments, dept_emp
WHERE employees.emp_no = dept_emp.emp_no
    AND dept_emp.dept_no = departments.dept_no
    AND to_date > NOW();`{{execute}}


After we have seen how joins work, we can continues on their variants.

Cross joins (aka cartesian products):

`SELECT employees.emp_no, first_name, last_name, departments.dept_no, dept_name, to_date
FROM employees
CROSS JOIN departments -- make cartesian product explicit
CROSS JOIN dept_emp    -- make cartesian product explicit
WHERE employees.emp_no = dept_emp.emp_no
    AND dept_emp.dept_no = departments.dept_no
    AND to_date > NOW();`{{execute}}

Explicit joins:
`SELECT employees.emp_no, first_name, last_name, departments.dept_no, dept_name, to_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE
    to_date > NOW();`{{execute}}

Joins on equality:

`SELECT employees.emp_no, first_name, last_name, departments.dept_no, dept_name, to_date
FROM employees
JOIN dept_emp USING (emp_no)     -- join on equality
JOIN departments USING (dept_no) -- join on equality
WHERE
    to_date > NOW();`{{execute}}


Joins on equality of columns with the same names (aka natural joins):

`SELECT employees.emp_no, first_name, last_name, departments.dept_no, dept_name, to_date
FROM employees
NATURAL JOIN dept_emp    -- join on equality
NATURAL JOIN departments -- of columns with the same name
WHERE
    to_date > NOW();`{{execute}}
