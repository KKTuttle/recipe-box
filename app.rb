require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

post('/recipes/ingredient_search') do
  @ingredient_search = params.fetch('ingredient_search').capitalize()
  @ingredient = Ingredient.find_by name: @ingredient_search
  if @ingredient
    @search_results = @ingredient.recipes()
  end
  erb(:search_results)
end

get('/recipes/new') do
  @ingredients = Ingredient.all()
  @tags = Tag.all()
  erb(:recipe_form)
end

post('/ingredients') do
  ingredient_name = params.fetch('ingredient_name')
  Ingredient.create({:name => ingredient_name})
  redirect back
end

post('/tags') do
  tag_name = params.fetch('tag_name')
  Tag.create({:name => tag_name})
  redirect back
end

post('/recipes') do
  recipe_name = params.fetch('recipe_name')
  ingredient_ids = params[:ingredient_ids]
  instructions = params.fetch('instructions')
  tag_ids = params[:tag_ids]
  @recipe = Recipe.create({:name => recipe_name, :ingredient_ids => ingredient_ids, :instruction => instructions, :tag_ids => tag_ids, :rating => 0})
  redirect('/recipes/'.concat(@recipe.id().to_s()))
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch('id').to_i())
  @tags = Tag.all() - @recipe.tags()
  @ingredients = Ingredient.all() - @recipe.ingredients()
  erb(:recipe)
end

get('/recipes') do
  @recipes = Recipe.order('rating DESC')
  erb(:recipes)
end

delete('/recipes/:id') do
  recipe = Recipe.find(params.fetch("id"))
  recipe.destroy()
  redirect ("/recipes")
end

patch('/recipes/:id') do
  if params.fetch("form_id").==("change_name")
    @recipe = Recipe.find(params.fetch('id').to_i())
    recipe_name = params.fetch('recipe_name')
    instructions = params.fetch('instructions')
    @recipe.update({:name => recipe_name, :instruction => instructions})

  elsif params.fetch("form_id").==("add_tags")
    new_tag_ids = params[:tag_ids]
    @recipe = Recipe.find(params.fetch('id').to_i())
    tag_ids_array = []
    @recipe.tags().each() do |tag|
      tag_ids_array.push(tag.id())
    end
    new_tag_ids.each() do |id|
      tag_ids_array.push(id)
    end
    @recipe.update({:tag_ids => tag_ids_array})

  elsif params.fetch("form_id").==("remove_tags")
    @recipe = Recipe.find(params.fetch('id').to_i())
    remove_tag_ids = params[:tag_ids]
    remove_tag_ids.each() do |id|
      @recipe.tags.destroy(Tag.find(id))
    end

  elsif params.fetch("form_id").==("add_ingredients")
    new_ingredient_ids = params[:ingredient_ids]
    @recipe = Recipe.find(params.fetch('id').to_i())
    ingredient_ids_array = []
    @recipe.ingredients().each() do |ingredient|
      ingredient_ids_array.push(ingredient.id())
    end
    new_ingredient_ids.each() do |id|
      ingredient_ids_array.push(id)
    end
    @recipe.update({:ingredient_ids => ingredient_ids_array})

  elsif params.fetch("form_id").==("remove_ingredients")
    @recipe = Recipe.find(params.fetch('id').to_i())
    remove_ingredient_ids = params[:ingredient_ids]
    remove_ingredient_ids.each() do |id|
      @recipe.ingredients.destroy(Ingredient.find(id))
    end

  else
    @recipe = Recipe.find(params.fetch('id').to_i())
    rating = params.fetch('rate_recipe')
    @recipe.update({:rating => rating})
  end
  redirect back
end


get('/tags') do
  @tags = Tag.all()
  erb(:tags)
end

get('/tags/:id') do
  @tag = Tag.find(params.fetch('id').to_i())
  erb(:tag)
end

patch('/tags/:id') do
  @tag = Tag.find(params.fetch('id').to_i())
  tag_name = params.fetch('tag_name')
  @tag.update({:name => tag_name})
  redirect back
end

delete("/tags/:id") do
  tag = Tag.find(params.fetch('id').to_i())
  tag.destroy()
  redirect ("/tags")
end
