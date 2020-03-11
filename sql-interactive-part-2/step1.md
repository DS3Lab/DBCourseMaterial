# Creating tables, inserting data and perform simple queries

Let's wait a bit until postgres is installed in the background. Once this is
done, change to the `postgres` user:

`su - postgres`{{execute}}

Then get a prompt:

`psql`{{execute}}

Have messages displayed in English:

`SET lc_messages TO 'en_US.UTF-8';`{{execute}}

Show all tables present in the database:

`select * from pg_catalog.pg_tables where schemaname = 'public';`{{execute}}

Then, create the artists database and connect to it:

`CREATE DATABASE artists;`{{execute}}

`\c artists`{{execute}}

Create the artists table:

`create table artists (
    artist_id int not null,
    name varchar(256) null,
    realname text null,
    profile text null,
    url text null,
    primary key (artist_id)
);`{{execute}}

Insert the data into the `artists` table:

`copy artists from '/var/lib/postgresql/artists.csv' delimiters ',' csv header;`{{execute}}

Show how many artists exist in the table:
`select count(*) from artists;`{{execute}}

Now let's try to insert "by hand" some values into the table.

`insert into artists values (124313250, 'myband1');`{{execute}}

`insert into artists (artist_id, name) values (124313251, 'myband2');`{{execute}}

Some insertions that can go wrong (why?):

`insert into artists (artist_id, name) values (124313251, 'myband1');`{{execute}}

`insert into artists (artist_id, name) values ('newid', 'myband3');`{{execute}}

Why does this insertion work?

`insert into artists values (124313252);`{{execute}}


Now that we have the `artists` table, let's create another one called releases:

`create table releases (
    release_id int not null,
    released date not null,
    title text not null,
    country varchar(256) null,
    genre varchar(256) not null,
    primary key (release_id)
);`{{execute}}

And bulk insert data into the table:

`copy releases from '/var/lib/postgresql/releases.csv' delimiters ',' csv header;`{{execute}}

Let's count again the number of releases and display the first 5 inserted:

`select count(*) from releases;`{{execute}}

`select * from releases limit 5;`{{execute}}

Now let's create a table that connects `releases` with `artists` called `released_by`:

`
create table released_by (
    release_id int not null,
    artist_id int not null,
    primary key (release_id, artist_id)
);`{{execute}}


And again bulk insert data into the table:

`copy released_by from '/var/lib/postgresql/released_by.csv' delimiters ',' csv header;`{{execute}}

Let's count the number of entries and display the first 5:

`select count(*) from released_by;`{{execute}}

`select * from released_by limit 5;`{{execute}}

The same restriction (which?) applies when we try to violate schema constraints:

`insert into released_by values (1, 1);`{{execute}}

But changing one attribute is enough:

`insert into released_by values (1, 2);`{{execute}}

Since we do not have foreign key constraints we can freely insert non-existing artists.
We first verify that the artist does not exist:

`select * from artists where artist_id = 12791247;`{{execute}}

Then we insert the non-existing artist into the `released_by` table:

`insert into released_by values (2, 12791247);`{{execute}}

And we verify that he/she is inserted correctly:

`select * from released_by where artist_id = 12791247;`{{execute}}


Finally, let's create the `tracks` table:

`create table tracks (
    release_id int not null,
    position varchar(128) null,
    title text null,
    duration int null
);`{{execute}}

And bulk insert data into it:

`copy tracks from '/var/lib/postgresql/tracks.csv' delimiters ',' csv header;`{{execute}}

We can get the first 10 entries and the tracks called "Eclipse" using the
two following queries:

`select * from tracks limit 10;`{{execute}}

`select * from tracks where title = 'Eclipse';`{{execute}}

