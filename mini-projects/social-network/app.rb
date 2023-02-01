require_relative 'lib/database_connection'
require_relative 'lib/account_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

repo = AccountRepository.new
accounts = repo.all

accounts.each {
  |account|
  p "#{account.id}. Username: #{account.username}, Email: #{account.email}."
}