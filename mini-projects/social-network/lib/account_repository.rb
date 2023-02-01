
require_relative 'account'

class AccountRepository
  def all
    sql = "SELECT id, username, email FROM accounts;"
    result_set = DatabaseConnection.exec_params(sql,[])

    accounts = []
    
    result_set.each{
      |record|
      account = Account.new
      account.id = record['id']
      account.username = record['username']
      account.email = record['email']

      accounts.push(account)
    }

    accounts
  end

  def find(id)
    sql = 'SELECT * FROM accounts WHERE id = $1;'
    record = DatabaseConnection.exec_params(sql,[id])[0]

    account = Account.new
    account.id = record['id']
    account.username = record['username']
    account.email = record['email']

    account
  end

  def create(new_account)
    sql = 'INSERT INTO accounts (username, email) VALUES($1,$2);'
    DatabaseConnection.exec_params(sql,[new_account.username, new_account.email])
  end

  def delete(id) 
    sql = 'DELETE FROM accounts WHERE id = $1'
    DatabaseConnection.exec_params(sql,[id])
  end

  def update(username, email, id)
    sql = 'UPDATE accounts SET username = $1, email = $2 WHERE id = $3;'
    DatabaseConnection.exec_params(sql,[username, email, id])
  end
end