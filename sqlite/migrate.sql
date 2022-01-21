PRAGMA foreign_keys=true;

create table content (
  content_id integer primary key,
  created_at text default CURRENT_TIMESTAMP,
  title text,
  html_path text,
  author_id text,
  shiori int
);

create table history (
  content_id integer,
  created_at text default CURRENT_TIMESTAMP,
  done int,
  descript text,
  foreign key (content_id) references content(content_id)
);
