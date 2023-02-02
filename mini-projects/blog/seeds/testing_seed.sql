
TRUNCATE TABLE posts, comments RESTART IDENTITY; -- replace with your own table name.

INSERT INTO posts (title, contents) VALUES ('Fire', 'Very hot');
INSERT INTO posts (title, contents) VALUES ('Water', 'Very cold');

INSERT INTO comments (comment_contents, post_id) VALUES ('So true, fire is so hot', 1);
INSERT INTO comments (comment_contents, post_id) VALUES ('So false, water can be hot too', 2);
INSERT INTO comments (comment_contents, post_id) VALUES ('Nah I touch fire all the time', 1);
