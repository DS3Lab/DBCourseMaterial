# Nested queries

Now that we have seen most of the basic operations that SQL can perform
(projections, selections, aggregations, joins) we can execute more advanced
queries. A way to do that in SQL is by nesting queries one inside the other.

For example, what does this query do?

`SELECT * FROM
(
    SELECT last_name, COUNT(*) AS c
    FROM employees
    GROUP BY last_name
) AS r1
WHERE c = 4;`{{execute}}

Now let's compute the number of occurrences of the most common name(s) but
without using any constants.

To start we compute the number of occurrences of the most common name(s):
`SELECT MAX(c)
FROM
(
    SELECT DISTINCT COUNT(*) AS c
    FROM employees
    GROUP BY last_name
) AS r2;`{{execute}}


Then we can nest the two queries together:
`SELECT * FROM
(
    SELECT last_name, COUNT(*) AS c
    FROM employees
    GROUP BY last_name
) AS r1
WHERE c = (
    SELECT MAX(c)
    FROM
    (
        SELECT DISTINCT COUNT(*) AS c
        FROM employees
        GROUP BY last_name
    ) AS r2
);`{{execute}}

Nesting queries is powerful but sometimes hard to read and understand. It's
better for readability to create intermediate results with the `WITH` clause.
For example we can rewrite the previous query in the following way:

`WITH name_counts AS
(
    SELECT last_name, COUNT(*) as count
    FROM employees
    GROUP BY last_name
), max_name_count AS
(
    SELECT MAX(count) as max_count
    FROM name_counts
)
SELECT last_name, count
FROM name_counts, max_name_count
WHERE count = max_count
ORDER BY max_count DESC;`{{execute}}

Let's find the minimum salary per department. As a rule of thumb, you should
always try to split the problem into smaller steps.

We first join the employees with their salaries and their department:

`SELECT emp_no, salary, dept_no
FROM employees
JOIN salaries USING(emp_no)
JOIN dept_emp USING(emp_no)
ORDER BY emp_no;`{{execute}

Then we calculate the minimum salary per department:

`SELECT MIN(salary) AS sal, dept_no
FROM employees
JOIN salaries USING(emp_no)
JOIN dept_emp USING(emp_no)
GROUP BY dept_no
ORDER BY sal;`{{execute}}

Finally, we combine the two above queries and by joining on the common columns:

`WITH emp_sal_dept AS
(
    SELECT emp_no, salary, dept_no
    FROM employees as e
    JOIN salaries as s USING(emp_no)
    JOIN dept_emp as de USING(emp_no)
    ORDER BY emp_no
), min_salaries AS
(
    SELECT MIN(salary) as salary, dept_no
    FROM emp_sal_dept
    GROUP BY dept_no
    ORDER BY salary
)
SELECT emp_no, dept_no, salary
FROM emp_sal_dept
JOIN min_salaries USING(dept_no, salary) -- pay attention, we join on both attributes
ORDER BY dept_no;`{{execute}}

The above query is not accurate because the salaries and employments have to
and from dates associated with them. We need to join only the employments and
the salaries which coexisted at the same time for a particular employee. Here is
the correct query:
`WITH emp_sal_dept AS
(
    SELECT emp_no, salary, dept_no
    FROM employees as e
    JOIN salaries as s USING(emp_no)
    JOIN dept_emp as de USING(emp_no)
    WHERE (s.from_date, s.to_date) OVERLAPS (de.from_date, de.to_date) -- This eliminates incorrect entries
    ORDER BY emp_no
), min_salaries AS
(
    SELECT MIN(salary) as salary, dept_no
    FROM emp_sal_dept
    GROUP BY dept_no
    ORDER BY salary
)
SELECT emp_no, dept_no, salary
FROM emp_sal_dept
JOIN min_salaries USING(dept_no, salary)
ORDER BY dept_no;`{{execute}}

Now, let's do a similar query to the one before. Specifically, we will for every
employee his salary and the average salary for his department.We break again the
problem into steps:

First we join the employee, salary and department tables:

`SELECT emp_no,
       salary,
       dept_no
FROM employees AS e
JOIN salaries AS s USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
WHERE (s.from_date,
       s.to_date) OVERLAPS (de.from_date,
                            de.to_date)
ORDER BY emp_no;`{{execute}}

Then, we find the average salary for a particular department:

`WITH emp_sal_dept AS
    ( SELECT emp_no,
             salary,
             dept_no
     FROM employees AS e
     JOIN salaries AS s USING(emp_no)
     JOIN dept_emp AS de USING(emp_no)
     WHERE (s.from_date,
            s.to_date) OVERLAPS (de.from_date,
                                 de.to_date)
     ORDER BY emp_no)
SELECT avg(salary) AS salary
FROM emp_sal_dept
WHERE dept_no = 'd005';`{{execute}}


Finally, we add the average to the employee, salary, department:

`WITH emp_sal_dept AS
    ( SELECT emp_no,
             salary,
             dept_no
     FROM employees AS e
     JOIN salaries AS s USING(emp_no)
     JOIN dept_emp AS de USING(emp_no)
     WHERE (s.from_date,
            s.to_date) OVERLAPS (de.from_date,
                                 de.to_date)
     ORDER BY emp_no)
SELECT emp_no,
       salary,
    ( SELECT avg(salary) AS avg_salary
     FROM emp_sal_dept
     WHERE emp_sal_dept.dept_no = emp_sal_dept_o.dept_no --reference to the outer relation
) , dept_no
FROM emp_sal_dept AS emp_sal_dept_o;`{{execute}}

Alternatively, we could solve the above query with a join:

`WITH emp_sal_dept AS
    ( SELECT emp_no,
             salary,
             dept_no
     FROM employees AS e
     JOIN salaries AS s USING(emp_no)
     JOIN dept_emp AS de USING(emp_no)
     WHERE (s.from_date,
            s.to_date) OVERLAPS (de.from_date,
                                 de.to_date)
     ORDER BY emp_no),
     avg_salaries AS
    ( SELECT dept_no,
             avg(salary) AS avg_salary
     FROM emp_sal_dept
     GROUP BY dept_no)
SELECT emp_no,
       salary,
       avg_salary,
       dept_no
FROM emp_sal_dept
JOIN avg_salaries USING(dept_no);`{{execute}}

For the final query, let's calculate the oldest managers per department:

`WITH max_age_dept AS
    ( SELECT max(age(birth_date)) AS max_age,
             dept_no
     FROM employees AS e
     JOIN dept_manager AS dm USING(emp_no)
     GROUP BY dept_no
     ORDER BY dept_no)
SELECT emp_no,
       age(birth_date)
FROM employees AS eo
JOIN dept_manager AS dmo USING(emp_no)
WHERE age(eo.birth_date) >=
        ( SELECT max_age
         FROM max_age_dept
         WHERE dept_no = dmo.dept_no );`{{execute}}

This query cannot be written with a join! The query would look like that:

`WITH emp_sal_dept AS
    ( SELECT emp_no,
             salary,
             dept_no
     FROM employees AS e
     JOIN salaries AS s USING(emp_no)
     JOIN dept_emp AS de USING(emp_no)
     WHERE (s.from_date,
            s.to_date) OVERLAPS (de.from_date,
                                 de.to_date)
     ORDER BY emp_no)
SELECT emp_no,
       salary,
       avg_salary,
       dept_no
FROM emp_sal_dept AS emp_sal_dept_o,

    ( SELECT avg(salary) AS avg_salary
     FROM emp_sal_dept
     WHERE emp_sal_dept.dept_no = emp_sal_dept_o.dept_no ) AS average_salary;`{{execute}}

However, the subquery has to be evaluated before the outer query,
so emp_sal_dept_o is not available to the subquery yet

