
require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, cohort_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @cohort_repository = cohort_repository
  end

  def run
    @io.puts "Type the id of the cohort would you like to see:"
    id_choice = @io.gets.chomp

  info = @cohort_repository.find_with_students(id_choice)
  @io.puts "#{info.name} Cohort:"
  info.students.each_with_index {
    |student, i|
    @io.puts "#{i+1}. #{student.name}"
  }
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'student_directory',
    Kernel,
    CohortRepository.new,
  )
  app.run
end