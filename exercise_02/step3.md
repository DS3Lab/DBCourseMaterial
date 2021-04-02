#### Querying
The questions in the exercises each refer to one of the three datasets we have created databases for.

To run queries on the datasets, we *connect* to them as follows:

##### Employees

``\c employee``{{execute}}

We can now run queries on the connected dataset. For example, to return employee's first names:

``
SELECT e.first_name
FROM employees e
LIMIT 5;
``{{execute}}

##### TPC-H and ZVV

We can use the same command to connect to the TPC-H dataset:

``\c tpch``{{execute}}

and the ZVV dataset:

``\c zvv``{{execute}}

Using the command line interface, we can now run and test different SQL queries 
that are discussed in the exercise.