# Post Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: posts

Columns:
id | title | content | views | account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, account_id) VALUES ('What I Like About Apples', 'They are nice and yummy', 100, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('What I Like About Watermelons', 'They are made of water', 200, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < posts_test_seed.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts;

    # Returns an array of Post objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;

    # Returns an instance of an Post object based on it's id.  
  end

  def create(new_post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, account_id) VALUES($1,$2,$3,$4);

    # Adds a new Post to the posts table
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1 ;

    # Deletes a post from the posts table based on id
  end

  def update_views(new_views, id)
    # Executes the SQL query:
    # UPDATE accounts SET views = $1 WHERE id = $2;

    # Update the details of an existing account based on it's id
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts
repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  '1'
posts[0].title # =>  'What I Like About Apples'
posts[0].content # =>  'They are nice and yummy'
posts[0].views # => '100'
posts[0].account_id # => '1'

posts[1].id # =>  '2'
posts[1].title # =>  'What I Like About Watermelons'
posts[1].content # =>  'They are made of water'
posts[1].views # => '200'
posts[1].account_id # => '2'

# 2
# Get one post based on ID
repo = PostRepository.new

post = repo.find(1)

posts.id # =>  '1'
posts.title # =>  'What I Like About Apples'
posts.content # =>  'They are nice and yummy'
posts.views # => '100'
posts.account_id # => '1'

# 3
# Adds a new post to the posts table
repo = PostRepository.new

post = Post.new
post.title = 'Why I like strawberries too'
post.content = 'I like them cuz I like berries'
post.views = 300
post.account_id = 2 

repo.create(post)

posts = repo.all

posts[2].id # =>  '3'
posts[2].title # =>  'Why I like strawberries too'
posts[2].content # =>  'I like them cuz I like berries'
posts[2].views # => '300'
posts[2].account_id # => '2'

# 4
# Deletes an account from the posts table based on id
repo = PostRepository.new

repo.delete(1)

posts = repo.all

posts.length # => 1

# 5
# Update the views of an existing post based on it's id
repo = PostRepository.new

repo.update(500, 1)

post = repo.find(1)

post.id # =>  '1'
post.title # =>  'What I Like About Apples'
post.content # =>  'They are nice and yummy'
post.views # => '500'
post.account_id # => '1'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('seeds/posts_test_seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._