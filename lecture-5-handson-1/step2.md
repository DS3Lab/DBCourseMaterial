# Inserting data

In this part of the session, we'll try inserting some data and seeing what works and what doesn't.

Let's try insert an artist 'by hand':

`INSERT INTO artists VALUES (124313250, ‘myband1’);`{{execute}}

We can explicitly state which attributes are inserted, allowing us to omit attributes
or re-order them in the query:

`INSERT INTO artists (artist_id, name) VALUES (124313251, 'myband2');`{{execute}}

### Erroneous insertions?

The following insertions may or may not complete successfully.
Before executing each query, try to predict what will happen.
If you think the insertion will cause an error, try to explain *why* it will occur.

`INSERT INTO artists VALUE (124313250, 'myband3');`{{execute}}

`INSERT INTO artists VALUE (’unique_id’, ‘myband4’);`{{execute}}

`INSERT INTO artists VALUE (124313252);`{{execute}}

The `released_by` table associates an artist with one of their releases by storing
the `artist_id` and `release_id` of the relevant artist and release respectively.

`SELECT * FROM artists WHERE artist_id = 24214812784;`{{execute}}

Since the above query returns no artists, will the below query work?

`INSERT INTO released_by VALUES (2, 24214812784);`{{execute}}

No! Because there is no foreign key constraint on `released_by`, this insertion satisfies
the schema constraints.