CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  contents text
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  comment_contents text,
  post_id int,
  constraint fk_post foreign key(post_id) references posts(id) on delete cascade
);