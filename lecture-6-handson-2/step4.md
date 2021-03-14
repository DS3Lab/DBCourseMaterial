# Projections

Let's perform some (more) projections on the data, beyond just filtering out attributes/columns
from the base table.

Renaming a column:

`SELECT name, url as link FROM artists WHERE name = 'Rick Astley';`{{execute}}

Projecting literals as columns in the result of the query:

`SELECT 'hi', 5, name FROM artists WHERE name = 'ILLENIUM';`{{execute}}

Duplicating columns:

`SELECT name, name FROM artists WHERE name = 'Linkin Park';`{{execute}}

Mathematical operations and boolean expression evaluation:

`SELECT title, duration/60, (duration > 360) FROM tracks LIMIT 10';`{{execute}}

String concatenation:

`SELECT title || ' - ' || genre FROM releases LIMIT 10;`{{execute}}

`SELECT title || ' ' || 5 FROM releases LIMIT 10;`{{execute}}

Special functions on dates:

`SELECT title, EXTRACT(year FROM released) AS release_year, AGE(released) AS age
    FROM releases
    LIMIT 10;`{{execute}}