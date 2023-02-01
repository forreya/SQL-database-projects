require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new
recipes = repo.all

recipes.each{
  |recipe|
  puts "#{recipe.id}. #{recipe.name}"
}