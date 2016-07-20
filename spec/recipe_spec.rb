require("spec_helper")

describe(Recipe) do
  it("has many ingredients") do
    test_recipe = Recipe.create({:name => "Sandwich"})
    test_ingredient1 = test_recipe.ingredients.new({:name => "Bread"})
    test_ingredient2 = test_recipe.ingredients.new({:name => "Tuna"})
    expect(test_recipe.ingredients()).to(eq([test_ingredient1, test_ingredient2]))
  end

  it("has many tags") do
    test_recipe = Recipe.create({:name => "Sandwich"})
    test_tag1 = test_recipe.tags.new({:name => "Easy"})
    test_tag2 = test_recipe.tags.new({:name => "Lunch"})
    expect(test_recipe.tags()).to(eq([test_tag1, test_tag2]))
  end

  it("ensures the name is present") do
    recipe = Recipe.new({:name => '', :instruction => 'cook'})
    expect(recipe.save()).to(eq(false))
  end

  it("ensures the name is less than 50 characters") do
    recipe = Recipe.new({:name => "a".*(51), :instruction => 'cook'})
    expect(recipe.save()).to(eq(false))
  end

  it("ensures the instruction is present") do
    recipe = Recipe.new({:name => "sandwhich", :instruction => ''})
    expect(recipe.save()).to(eq(false))
  end

  it("ensures the instruction is less than 1500 characters") do
    recipe = Recipe.new({:name => "sandwhich", :instruction => "a".*(1501)})
    expect(recipe.save()).to(eq(false))
  end

  it("upcases the recipe name") do
    recipe = Recipe.create({:name => 'sandwhich', :instruction => 'cook'})
    expect(recipe.name()).to(eq('SANDWHICH'))
  end
end
