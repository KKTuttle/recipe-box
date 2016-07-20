require("spec_helper")

describe(Ingredient) do
  it("belongs to a recipe") do
    test_recipe = Recipe.create({:name => "Sandwich"})
    test_ingredient1 = test_recipe.ingredients.new({:name => "Bread"})
    expect(test_recipe.ingredients()).to(eq([test_ingredient1]))
  end

  it("ensures the name is present") do
    ingredient = Ingredient.new({:name => ''})
    expect(ingredient.save()).to(eq(false))
  end

  it("ensures the name is less than 50 characters") do
    ingredient = Ingredient.new({:name => "a".*(51)})
    expect(ingredient.save()).to(eq(false))
  end

  it("capitalizes the ingredient") do
    ingredient = Ingredient.create({:name => 'bacon'})
    expect(ingredient.name()).to(eq('Bacon'))
  end
end
