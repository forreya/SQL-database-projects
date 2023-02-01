# Two Tables Design Recipe for Social Network

## 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.
```

```
Nouns:

user account, email address, username, post, title, content, views

```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record  | Properties               |
| ------- | ------------------------ |
| account | email, username          |
| post    | title, content, views    |

1. Name of the first table (always plural): `accounts`

Column names: `email`, `username`

2. Name of the second table (always plural): `posts`

Column names: `title`, `content`, `views`

## 3. Decide the column types.

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: accounts
id: SERIAL
username: text
email: text

Table: posts
id: SERIAL
title: text
content: text
views: int

```

## 4. Decide on The Tables Relationship

```
The foreign key is on the posts table.
```

## 4. Write the SQL.

```sql

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

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < social_network_database.sql
```
