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
  ingredients = params.fetch('ingredient_ids')
  @ingredients = []
  ingredient_ids.each() do |ingredient_id|
   ingredient = Ingredient.find(ingredient_id)
   @ingredients.push(ingredient)
  end
  instructions = params.fetch('instructions')
  @recipe = Recipe.create({:name => name, :instructions => instructions})
  redirect('/recipes/'.concat(@recipe.id().to_s()))
end
