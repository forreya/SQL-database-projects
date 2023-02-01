
require_relative './recipe'

class RecipeRepository
  def all
    sql = "SELECT id, name, cooking_time, rating FROM recipes;"
    result_set = DatabaseConnection.exec_params(sql,[])

    recipes = []
    
    result_set.each{
      |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time'].to_i
      recipe.rating = record['rating'].to_i

      recipes.push(recipe)
    }

    recipes
  end

  def find(id)
    sql = "SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;"
    result_set = DatabaseConnection.exec_params(sql,[id])[0]

    recipe = Recipe.new
    recipe.id = result_set['id']
    recipe.name = result_set['name']
    recipe.cooking_time = result_set['cooking_time'].to_i
    recipe.rating = result_set['rating'].to_i
    
    recipe
  end
end