# Projections, joins, and aggregations

Let's start by doing some simple projections on our data. First we will get the
ten first entries and the artists called "Radiohead":

`select * from artists limit 10;`{{execute}}

`select * from artists where name = 'Radiohead';`{{execute}}

The `LIKE` keyword does a pattern matching in the respective attribute. For
example the following query will return the name, profile, and url of all
artist entries that contain the substring "Beatles".

`select name, profile, url from artists where name LIKE '%Beatles%';`{{execute}}

The "%" character consumes
all the characters that occur before and/or after the word. For example if you
have as a condition the following string "%Beatles%", then if the name contains
any number of characters then the word "Beatles" and again any number of characters
after that, the condition evaluates to true.

Some more projections with the `LIKE` keyword:

`select name, url as link from artists where name LIKE '%Beatles%';`{{execute}}

`select 'hi', name, url as link from artists where name LIKE '%Beatles%';`{{execute}}


And more complex projections on our tables:

`select url, url from artists where name = 'Radiohead';`{{execute}}

`
select release_id, releases.title, duration/60
from releases, tracks
where releases.title LIKE '%Dark Side Of The Moon%' and
  tracks.title = 'Eclipse';`{{execute}}

We have seen the concatenation function the last time:

`
select name, name || '_' || name
from artists
where name = 'Radiohead';`{{execute}}

`
select name, name || '_' || realname
from artists
where name = 'Radiohead';`{{execute}}

We have also seen some special function on dates:

`
select id, title, released, extract(year from released)
from releases
where title LIKE '%OK Computer%';`{{execute}}

After the projections, let's perform some joins on the tables.

Cartesian product:
`select count(*) from artists, releases, released_by;`{{execute}}

Select only the rows that join:
`
select count(*) from artists, releases, released_by
where artists.artist_id = released_by.artist_id and
releases.release_id = released_by.release_id;`{{execute}}

And display only the first 10 results:

`
select *
from artists, releases, released_by
where artists.artist_id = released_by.artist_id and
  releases.release_id = released_by.release_id
limit 10;`{{execute}}

Find all releases by an artist:

`
select * from artists, releases, released_by
where artists.artist_id = released_by.artist_id and
  releases.release_id = released_by.release_id and
  artists.name = 'Radiohead';`{{execute}}

In case there are duplicate entries we can remove them with the `DISTINCT` keyword:

`
select distinct releases.title
from artists, releases, released_by
where artists.artist_id = released_by.artist_id and
  releases.release_id = released_by.release_id and
  artists.name = 'Radiohead';`{{execute}}

Other ways to perform joins:

`select * from
    artists
    join released_by on artists.artist_id = released_by.artist_id
    join releases on released_by.release_id = releases.release_id
    limit 10;`{{execute}}

`select * from
    artists
    join released_by using(artist_id)
    join releases using(release_id)
    limit 10;`{{execute}}

`select * from
    artists
    natural join released_by
    natural join releases
    limit 10;`{{execute}}

We can also perform some selection on the results of the join:

`
select releases.release_id, releases.title
from releases, tracks
where releases.release_id = tracks.release_id
  and tracks.title = 'Eclipse'
  and extract(year from releases.released) < 1980;`{{execute}}


Now that we have seen joins let's also perform some simple aggregations.

Track with maximum duration:
`select max(duration) from tracks;`{{execute}}

Number of different titles in the `releases` table:

`select count(distinct title) from releases;`{{execute}}

Number of titles and distinct titles in the `releases` table:

`select count(*), count(distinct title) from releases;`{{execute}}

Longest tracks:

`select title, duration from tracks order by duration desc limit 10;`{{execute}}

Releases with longest tracks:

`
select releases.title, tracks.title, duration
from releases join tracks using(release_id)
order by duration desc
limit 10;`{{execute}}

Artists with releases with longest tracks:

`select artists.name, releases.title, tracks.title, duration from
    releases join tracks using(release_id)
    join released_by using (release_id)
    join artists using(artist_id)
    order by duration desc limit 10;`{{execute}}

Find how often a name occurs:

`
select title, count(*)
from releases where title = 'Eclipse'
group by title;`{{execute}}


Find how often a name occurs and order by the largest counts:

`
select title, count(*)
from releases
where title like '%Eclipse%'
group by title
order by count(*) desc;`{{execute}}


Show any genre each release that contains the string "Eclipse" has:

`
select max(genre), title, count(*)
from releases
where title like '%Eclipse%'
group by title
order by count(*) desc;`{{execute}}

Find titles that occur 42 times:

`select title, count(*)
from releases
group by title
having count(*) = 42;`{{execute}}
