PRAGMA foreign_keys=true;

create table author (
  author_id integer primary key,
  author_html_url text
);

create table content (
  content_id integer primary key,
  created_at text default CURRENT_TIMESTAMP,
  title text,
  content_html_url text,
  author_id integer,
  shiori int,
  foreign key (author_id) references author(author_id)
);

create table history (
  content_id integer,
  created_at text default CURRENT_TIMESTAMP,
  done int,
  descript text,
  foreign key (content_id) references content(content_id)
);
