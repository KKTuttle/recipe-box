require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes/new') do
  @ingredients = Ingredient.all()
  erb(:recipe_form)
end

post('/ingredients') do
  name = params.fetch('name')
  Ingredient.create({:name => name})
  redirect back
end

post('/recipes') do
  name = params.fetch('name')
  ingredient_ids = params.fetch('ingredient_ids')
  instructions = params.fetch('instructions')
  @recipe = Recipe.create({:name => name, :ingredient_ids => ingredient_ids, :instruction => instructions})
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch('id').to_i())
  erb(:recipe)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end
