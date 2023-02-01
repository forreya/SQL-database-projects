
DROP TABLE IF EXISTS "public"."accounts";
CREATE SEQUENCE IF NOT EXISTS accounts_id_seq;
DROP TABLE IF EXISTS "public"."posts";
CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text,
  email text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  account_id int,
  constraint fk_account foreign key(account_id)
    references accounts(id)
    on delete cascade
);

INSERT INTO "public"."accounts" ("username", "email") VALUES
('Ryan', 'ryan@gmail.com'),
('Emma', 'emma@gmail.com'),
('John', 'john@gmail.com');

INSERT INTO "public"."posts" ("title", "content", "views", "account_id") VALUES
('Emma Title', 'Emma Content', 500, 2),
('Ryans Other Title', 'Ryans Other Content', 800, 1),
('John Title', 'John Content', 100, 3),
('Ryan Title', 'Ryan Content', 400, 1);
