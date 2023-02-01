
require 'book_repository'

describe BookRepository do
  def reset_books_table
    seed_sql = File.read('seeds/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_table
  end

  it 'returns an array of all the books' do
    repo = BookRepository.new

    books = repo.all

    expect(books.length).to eq 2

    expect(books[0].id).to eq '1'
    expect(books[0].title).to eq 'Deception Point'
    expect(books[0].author_name).to eq 'Dan Brown'

    expect(books[1].id).to eq '2'
    expect(books[1].title).to eq 'The Ryan Book'
    expect(books[1].author_name).to eq 'Ryan Lai'

  end
  
end