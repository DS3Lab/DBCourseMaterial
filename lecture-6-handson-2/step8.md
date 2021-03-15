# Nesting

In the previous step we saw how to find titles that occur 42 times:

`SELECT title, COUNT(*)
    FROM releases
    GROUP BY title
    HAVING COUNT(*) = 42;`{{execute}}

We can extract the same information using a nested query:

`SELECT *
    FROM (
	    SELECT title, count(*) as c1
	    FROM releases
	    GROUP BY title
    ) as S1
    WHERE c1 = 42;`{{execute}}

Notice how we give the subquery an *alias* (`S1`). Whenever `SELECT ... FROM` a subquery,
we need to give it an alias first.

The following sections will try to formulate more complex queries using nesting given a simple
English description of what the query should do. 

It's good practice to try writing these without looking at the solution. 
Its important to always keep in mind:
1. What information do we need to answer this query?
2. Which tables store that information?


#### Finding the most common release title(s) using nesting

Naively, we can do this:

`SELECT title, COUNT(*)
    FROM releases
    GROUP BY title
    ORDER BY COUNT(*) DESC
    LIMIT 1;`{{execute}}

However, what if there is a tie? How do we decide which one to return? Let's first find how many
times the most common release title occurs:

`SELECT MAX(c) 
    FROM (
        SELECT DISTINCT COUNT(*) AS c
        FROM releases 
        GROUP BY TITLE
    ) AS S1;`{{execute}}

Then, we can find all releases that occur exactly that many times:

`SELECT title, COUNT(*)
    FROM releases
    GROUP BY title
    HAVING COUNT(*) = (
        SELECT MAX(c)
        FROM (
            SELECT DISTINCT COUNT(*) as c
            FROM releases
            GROUP BY title
        ) AS S1
    );`{{execute}}

#### Finding the top 10 artist(s) with the most releases

Firstly, let's find the number of releases the top 10 artists have:

`SELECT COUNT(*)
    FROM artists
    JOIN released_by USING (artist_id)
    JOIN releases USING (release_id)
    GROUP BY artist_id
    ORDER BY COUNT(*) DESC
    LIMIT 10;`{{execute}}

Are we done? What if the 10th artist has the same number of releases as the 11th artist? 

`SELECT A.artist_id, A.name, COUNT(*)
    FROM artists A
    JOIN released_by RB USING (artist_id)
    JOIN releases R USING (release_id)
    GROUP BY A.artist_id, A.name
    HAVING COUNT(*) >= ANY (
        SELECT COUNT(*)
        FROM artists
        JOIN released_by USING (artist_id)
        JOIN releases USING (release_id)
        GROUP BY artist_id
        ORDER BY COUNT(*) DESC
        LIMIT 10
    )
    ORDER BY COUNT(*) DESC;`{{execute}}

Now, we find all artists that have *at least as many* releases as *any* of the artists in the top 10 (`>= ANY`).
This covers the case of a tie.

#### Some more queries that may be interesting:

Average song duration for a specific artist:

`SELECT AVG(duration)
    FROM artists
    JOIN released_by USING (artist_id)
    JOIN releases USING(release_id)
    JOIN tracks USING (release_id)
    WHERE artists.name = 'Radiohead';`{{execute}}

Average song duration *per album* for an artist:

`SELECT releases.release_id, AVG(duration)
    FROM artists
    JOIN released_by USING (artist_id)
    JOIN releases USING(release_id)
    JOIN tracks USING (release_id)
    WHERE artists.name = 'Radiohead'
    GROUP BY releases.release_id
    ORDER BY AVG(duration) DESC;`{{execute}}

Average *total* album duration for *each* artist:

`SELECT D.artist_id, D.name, AVG(D.duration)
    FROM (
        SELECT SUM(duration) as duration, RB.artist_id, A.name
        FROM artists A, releases R, released_by RB, tracks T
        WHERE R.release_id = RB.release_id
        AND R.release_id = T.release_id
        AND A.artist_id = RB.artist_id
        GROUP BY RB.artist_id, A.name, R.release_id
    ) AS D
    GROUP BY D.artist_id, D.name
    ORDER BY AVG(D.duration) DESC
    LIMIT 10;`{{execute}}