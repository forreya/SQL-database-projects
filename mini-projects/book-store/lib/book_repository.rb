require_relative 'book'

class BookRepository
  def all
    sql = 'SELECT * FROM books;'
    result_set = DatabaseConnection.exec_params(sql,[])

    books = []

    result_set.each {
      |record|
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']

      books.push(book)
    }

    books
  end
end