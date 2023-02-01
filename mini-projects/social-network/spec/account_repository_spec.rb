
require 'account_repository'

describe AccountRepository do
  def reset_accounts_table
    seed_sql = File.read('seeds/accounts_test_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_accounts_table
  end

  it 'return an array of all accounts' do
    repo = AccountRepository.new

    accounts = repo.all
    
    expect(accounts.length).to eq 2
    
    expect(accounts[0].id).to eq '1'
    expect(accounts[0].username).to eq 'apple'
    expect(accounts[0].email).to eq 'apple@gmail.com'
    
    expect(accounts[1].id).to eq '2'
    expect(accounts[1].username).to eq 'watermelon'
    expect(accounts[1].email).to eq 'watermelon@gmail.com'
  end
  
  it 'returns one account based on its id' do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq '1'
    expect(account.username).to eq 'apple'
    expect(account.email).to eq 'apple@gmail.com'
  end

  it 'creates a new account in the database' do
    repo = AccountRepository.new

    account = Account.new
    account.username = 'blackberry'
    account.email = 'blackberry@gmail.com'

    repo.create(account)

    accounts = repo.all

    expect(accounts[2].id).to eq '3'
    expect(accounts[2].username).to eq 'blackberry'
    expect(accounts[2].email).to eq 'blackberry@gmail.com'
  end

  it 'deletes an account based on its id' do
    repo = AccountRepository.new

    repo.delete(1)
    
    accounts = repo.all
    expect(accounts.length).to eq 1
  end

  it 'updates an account based on its id' do
    repo = AccountRepository.new

    repo.update('banana', 'banana@gmail.com', 1)
    
    account = repo.find(1)
    
    expect(account.id).to eq '1'
    expect(account.username).to eq 'banana'
    expect(account.email).to eq 'banana@gmail.com'
  end
end