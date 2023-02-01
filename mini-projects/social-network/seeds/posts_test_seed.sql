
TRUNCATE TABLE accounts, posts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO accounts (username, email) VALUES ('apple', 'apple@gmail.com');
INSERT INTO accounts (username, email) VALUES ('watermelon', 'watermelon@gmail.com');

INSERT INTO posts (title, content, views, account_id) VALUES ('What I Like About Apples', 'They are nice and yummy', 100, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('What I Like About Watermelons', 'They are made of water', 200, 2);