# Aggregations

Now that we have seen joins, let's perform some simple aggregations.

The duration of the longest track:

`SELECT MAX(duration) FROM tracks;`{{execute}}

Number of unique album/release titles:

`SELECT COUNT(DISTINCT title) FROM releases;`{{execute}}

#### Aggregations with grouping
It's not very useful to only be able to aggregate (MAX/COUNT etc.) at a table level. We can
*group* together all tuples with the same value for an attribute using the `GROUP BY` keyword. 

`SELECT title, COUNT(*)
    FROM releases
    GROUP BY title
    LIMIT 10;`{{execute}}

What this does is first form groups (can be thought of as buckets/mini-relations) of tuples, such
that each group only contains titles with the same tuple. There will be one group for each distinct
`title` in `releases`.

Then, we specify the aggregation function (`COUNT(*)`) which is applied at a group level to 
produce our final result.

#### Counting releases with a specific title?

Let's say we want to count the number of releases with a given title. Do we need the `GROUP BY`?

We can do that very simply counting after a filter:

`SELECT COUNT(*)
    FROM releases
    WHERE title = 'Reverence';`{{execute}}

What if we wanted to return the title as well?

`SELECT title, COUNT(*)
    FROM releases
    WHERE title = 'Reverence';`{{execute}}

Why does this fail? When we apply the `COUNT(*)` function without a `GROUP BY`, it applies
the function to the *entire* table, whereas the `title` attribute belongs to either a tuple or
a group and does not exist at the table level. So we include the `GROUP BY`, even though the
filtered table will only produce one group (title = 'Reverence');

`SELECT title, COUNT(*)
    FROM releases
    WHERE title = 'Reverence'
    GROUP BY title;`{{execute}}

#### Sorting by aggregation result

We can also find the most frequent titles:

`SELECT title, COUNT(*) as freq
    FROM releases
    GROUP BY title
    ORDER BY freq DESC
    LIMIT 10;`{{execute}}

#### Filtering by aggregation results

If we want to filter (select) based on the result of the aggregation function (e.g. `COUNT`),
we can't do that in the `WHERE` clause, which filters on tuples/rows rather than groups.
Instead, we can using the `HAVING` clause:

`SELECT title, COUNT(*)
    FROM releases
    GROUP BY title
    HAVING COUNT(*) = 42;`{{execute}}