# Nested and complex queries

In the previous step we saw how to find the titles that occur 42 times with the
following subquery:

`
select title, count(*)
from releases
group by title
having count(*) = 42;`{{execute}}

However, we can extract the same information using a nested query:

`select * from
(select title, count(*) as c1 from releases group by title) as s1
where c1 = 42;`

Now, we are going to find the most common title name. We will split the query
into steps. We will first find how many times the most common name occurs:

`select max(c) from
(select distinct count(*) as c from releases group by title) as sub;`{{execute}}

Then we will combine this query to find the most common title name:

`select * from
(select title, count(*) as c from releases group by title) as sub1
where c =
(
    select max(c) from
    (select distinct count(*) as c from releases group by title) as sub2
);`{{execute}}


A less verbose way to extract the same information is the following:

`
select distinct title, count(*) as c
from releases
group by title
order by count(*) desc
limit 1;`{{execute}}


Let's find the most common genre. Again we will split the query into steps.
First, we will find how many times each genre occurs:

`select genre, count(*) from releases group by genre;`{{execute}}

Then, we will just keep the genre that occurs the most times:

`
select genre, count(*)
from releases
group by genre
order by count(*)
desc limit 1;`{{execute}}

Let's find the artist with the most releases. We will first find the artists and
the releases they have.

`select artist_id, count(*) from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    limit 10;`{{execute}}

We will then sort them by their releases:

`select artist_id, count(*) from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    group by artist_id
    order by count(*) desc;`{{execute}}

Finally, we will combine the above queries to find the artist with the most
releases:
`select artists.name, sub1.num_releases from artists,
(
select artist_id, count(*) as num_releases from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    group by artist_id
    order by count(*) desc limit 1
) as sub1
where artists.artist_id = sub1.artist_id;`{{execute}}

Let's calculate the average song duration for Radiohead.

`select avg(duration) from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    join tracks using(release_id)
    where artists.name = 'Radiohead';`{{execute}}

And the average album duration for Radiohead:
`select releases.title, avg(duration) from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    join tracks using(release_id)
    where artists.name = 'Radiohead'
    group by releases.title
    order by avg(duration) desc;`{{execute}}

As a final query we will calculate the album with the most tracks. We will do
that in 4 steps.

Step 1: Find the tracks per album.

`select * from
    releases join tracks using(release_id)
    limit 10;`{{execute}}

Step 2: Find the number of tracks per album:

`select release_id, count(*) from
    releases join tracks using(release_id)
    group by release_id
    limit 10;`{{execute}}

Step 3: Find the albums with the most tracks:

`select release_id, count(*) from
    releases join tracks using(release_id)
    group by release_id
    order by count(*) desc
    limit 10;`{{execute}}

Step 4: Combine the previous queries to find the album with the most tracks:

`select *, sub1.num_tracks from releases,
(
select release_id, count(*) as num_tracks from
    releases join tracks using(release_id)
    group by release_id
    order by count(*) desc
    limit 1
) as sub1
where sub1.release_id = releases.release_id;`{{execute}}

