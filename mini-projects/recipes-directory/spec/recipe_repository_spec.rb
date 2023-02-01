
require 'recipe_repository'

describe RecipeRepository do
  def reset_recipes_table
    seed_sql = File.read('seeds/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end

  it 'returns an array of all recipes' do
    repo = RecipeRepository.new
    recipes = repo.all 

    expect(recipes.length).to eq 2
    expect(recipes.first.id).to eq '1'
    expect(recipes.first.name).to eq 'Honest Burger'
    expect(recipes.first.cooking_time).to eq 12
    expect(recipes.first.rating).to eq 5
  end

  it 'returns a recipe based on a given id' do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq '2'
    expect(recipe.name).to eq 'Matcha Latte'
    expect(recipe.cooking_time).to eq 2
    expect(recipe.rating).to eq 4

  end
end