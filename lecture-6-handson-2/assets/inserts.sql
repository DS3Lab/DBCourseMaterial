create table artists (
    artist_id int not null,
    name varchar(256) null,
    realname text null,
    profile text null,
    url text null,
    primary key (artist_id)
);

create table releases (
    release_id int not null,
    released date not null,
    title text not null,
    country varchar(256) null,
    genre varchar(256) not null,
    primary key (release_id)
);

create table released_by (
    release_id int not null,
    artist_id int not null,
    primary key (release_id, artist_id)
);

create table tracks (
    release_id int not null,
    position varchar(128) null,
    title text null,
    duration int null
);

COPY artists FROM '/var/lib/postgresql/artists.csv' delimiters ',' csv header;
COPY releases FROM '/var/lib/postgresql/releases.csv' delimiters ',' csv header;
COPY released_by FROM '/var/lib/postgresql/released_by.csv' delimiters ',' csv header;
COPY tracks FROM '/var/lib/postgresql/tracks.csv' delimiters ',' csv header;