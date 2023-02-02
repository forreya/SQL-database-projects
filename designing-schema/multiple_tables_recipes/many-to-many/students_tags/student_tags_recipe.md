# Two Tables (Many-to-Many) Design Recipe Template

_Copy this recipe template to design and create two related database tables having a Many-to-Many relationship._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORIES:

As a coach
So I can get to know all students
I want to keep a list of students' names.

As a coach
So I can get to know all students
I want to assign tags to students (for example, "happy", "excited", etc).

As a coach
So I can get to know all students
I want to be able to assign the same tag to many different students.

As a coach
So I can get to know all students
I want to be able to assign many different tags to a student.
```

```
Nouns:

student, name, tag, tag_name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| student               | student_name
| tag                   | tag_name
| connection            | student_id, tag_id

1. Name of the first table (always plural): `students` 

    Column names: `student_name`, `id`

2. Name of the second table (always plural): `tags` 

    Column names: `tag_name`, `id`

3. Name of the third table (always plural): `connections` 

    Column names: `student_id`, `tag_id`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
student_name: text

Table: tags
id: SERIAL
tag_name: text

Table: connections
student_id: int
tag_id: int
```

## 4. Design the Many-to-Many relationship

```

1. Can one student have many tags? YES
2. Can one tag have many students? YES
```

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

```
# EXAMPLE

Join table for tables: students and tags
Join table name: connections
Columns: student_id, tag_id
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: students_tags.sql

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name text,
);

-- Create the second table.
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag_name text
);

-- Create the join table.
CREATE TABLE connections (
  student_id int,
  tag_id int,
  constraint fk_student foreign key(student_id) references students(id) on delete cascade,
  constraint fk_tag foreign key(tag_id) references tags(id) on delete cascade,
  PRIMARY KEY (student_id, tag_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < students_tags.sql
```