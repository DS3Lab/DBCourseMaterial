# Joins

We often want to perform queries that work over information stored in two separate tables. Here, we
use joins.

The most rudimentary way to join two tables together is the *cartesian product*:

`SELECT * 
    FROM artists, releases, released_by
    LIMIT 1;`{{execute}}

However, this generates ALL combinations of tuples, which is rarely what we want. We can specify
a condition to only join together tuples which share key fields:

`SELECT artists.name, releases.title
    FROM artists, releases, released_by
    WHERE artists.artist_id = released_by.artist_id
    AND releases.release_id = released_by.release_id
    LIMIT 10;`{{execute}}

This can take a long time to type, so we can give our base tables *aliases* which make things
a bit faster.

`SELECT A.name, R.title
    FROM artists A, releases R, released_by RB
    WHERE A.artist_id = RB.artist_id
    AND R.release_id = RB.release_id
    LIMIT 10;`{{execute}}

We can also filter out tuples in rows, just like any other query:

`SELECT A.name, R.title
    FROM artists A, releases R, released_by RB
    WHERE A.artist_id = RB.artist_id
    AND R.release_id = RB.release_id
    AND A.name = 'Radiohead';`{{execute}}

Duplicate entries can be eliminated with the `DISTINCT` keyword.

`SELECT DISTINCT A.name, R.title
    FROM artists A, releases R, released_by RB
    WHERE A.artist_id = RB.artist_id
    AND R.release_id = RB.release_id
    AND A.name = 'Radiohead';`{{execute}}

#### Join variants

There are a lot of ways to join tables together in SQL.

Joins using the `JOIN ON` keyword, which returns rows satisfying a boolean expression:

`SELECT A.name, R.title
    FROM artists A
    JOIN released_by RB ON A.artist_id = RB.artist_id
    JOIN releases R ON RB.release_id = R.release_id
    LIMIT 10;`{{execute}}

Joins using the `USING` keyword, which checks for equality based on a shared attribute name:

`SELECT A.name, R.title
    FROM artists A
    JOIN released_by RB USING(artist_id)
    JOIN releases R USING(release_id)
    LIMIT 10;`{{execute}}

Joins using the 'NATURAL JOIN' keyword, which finds *all* common attribute names and joins
based on those being equal:

`SELECT A.name, R.title
    FROM artists A
    NATURAL JOIN released_by RB
    NATURAL JOIN releases R
    LIMIT 10;`{{execute}}

There's another subtle difference with the `NATURAL JOIN` keyword. See if you can spot it.