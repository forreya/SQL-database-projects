# Account Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: accounts

Columns:
id | username | email
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

TRUNCATE TABLE accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email) VALUES ('apple', 'apple@gmail.com');
INSERT INTO accounts (username, email) VALUES ('watermelon', 'watermelon@gmail.com');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < accounts_test_seed.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/book.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email
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
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email FROM accounts;

    # Returns an array of Account objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT * FROM accounts WHERE id = $1;

    # Returns an instance of an Account object based on it's ID.  
  end

  def create(new_account)
    # Executes the SQL query:
    # INSERT INTO accounts (username, email) VALUES($1,$2);

    # Adds a new Account to the accounts table
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1 ;

    # Deletes an account from the accounts table based on id
  end

  def update(username, email, id)
    # Executes the SQL query:
    # UPDATE accounts SET username = $1, email = $2 WHERE id = $3;

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
# Get all accounts
repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  '1'
accounts[0].username # =>  'apple'
accounts[0].email # =>  'apple@gmail.com'

accounts[1].id # =>  '2'
accounts[1].username # =>  'watermelon'
accounts[1].email # =>  'watermelon@gmail.com'

# 2
# Get one account based on ID
repo = AccountRepository.new

account = repo.find(1)

account.id # => '1'
account.username # => 'apple'
account.email # => 'apple@gmail.com

# 3
# Adds a new account to the accounts table
repo = AccountRepository.new

account = Account.new
account.username = 'blackberry'
account.email = 'blackberry@gmail.com'

repo.create(account)

accounts = repo.all

accounts[2].id # =>  '3'
accounts[2].username # => 'blackberry'
accounts[2].email # => 'blackberry@gmail.com'

# 4
# Deletes an account from the accounts table based on id
repo = AccountRepository.new

repo.delete(1)

accounts = repo.all

accounts.length # => 1

# 5
# Update the details of an existing account based on it's id
repo = AccountRepository.new

repo.update('banana', 'banana@gmail.com', 1)

account = repo.find(1)

account.id # => '1'
account.username # => 'banana'
account.email # => 'banana@gmail.com'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('seeds/accounts_test_seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._