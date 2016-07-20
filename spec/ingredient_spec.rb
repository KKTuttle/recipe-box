require("spec_helper")

describe(Ingredient) do
  it("belongs to a recipe") do
    test_recipe = Recipe.create({:name => "Sandwich"})
    test_ingredient1 = test_recipe.ingredients.new({:name => "Bread"})
    expect(test_recipe.ingredients()).to(eq([test_ingredient1]))
  end
end
