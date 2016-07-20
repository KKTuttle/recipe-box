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
  @ingredients = []
  ingredient_ids_integers = []
  ingredient_ids.each() do |ingredient_id|
   ingredient = Ingredient.find(ingredient_id.to_i())
   @ingredients.push(ingredient)
   ingredient_ids_integers.push(ingredient_id.to_i())
  end
  instructions = params.fetch('instructions')
  @recipe = Recipe.create({:name => name, :instruction => instructions, :ingredient_ids => ingredient_ids_integers})
  redirect('/recipes/'.concat(@recipe.id().to_s()))
end
