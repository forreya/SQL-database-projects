
require_relative 'lib/database_connection'
require_relative 'lib/post_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    @io.puts "Type the id of the post would you like to see:"
    id_choice = @io.gets.chomp

  info = @post_repository.find_with_comments(id_choice)
  @io.puts "#{info.title}"
  @io.puts "Comments:"
  info.comments.each_with_index {
    |comment, i|
    @io.puts "#{i+1}. #{comment.comment_contents}"
  }
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'blog_test',
    Kernel,
    PostRepository.new,
  )
  app.run
end