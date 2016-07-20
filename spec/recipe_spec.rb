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
end
