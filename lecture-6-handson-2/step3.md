# Basic queries

Let's perform some very simple queries on our data. Firstly, let's retrive all the
artists called "Radiohead".

`SELECT * FROM artists WHERE name = 'Radiohead';`{{execute}}

If you don't know the exact name of an artist (up to the casing) it can we helpful to know 
the following keywords:

#### Like

The `LIKE` keyword does a pattern matching in the respective attribute. For
example the following query will return the name, profile, and url of all
artist entries that contain the substring "Beatles".

`SELECT name, profile, url FROM artists WHERE name LIKE '%Beatles%';`{{execute}}

The "%" character allows an arbitrary number of characters before and/or after the pattern.
If there is no "%" before the pattern, then it will only match values that *start*
with "Beatles".

#### Case casts

The `UPPER` and `LOWER` functions transform a string to upper/lower case, allowing you to
match strings more dynamically:

`SELECT name, profile, url from artists where UPPER(name) = 'DJ BOBO';`{{execute}}