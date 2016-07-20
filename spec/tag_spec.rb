require("spec_helper")

describe(Tag) do
  it("belongs to a recipe") do
    test_recipe = Recipe.create({:name => "Sandwich"})
    test_tag = test_recipe.tags.new({:name => "Easy"})
    expect(test_recipe.tags()).to(eq([test_tag]))
  end
end
