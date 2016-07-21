require("spec_helper")

describe(Recipe) do
  it {should have_and_belong_to_many(:ingredients)}

  it {should have_and_belong_to_many(:tags)}

  it {should validate_presence_of(:name)}

  it {should validate_length_of(:name)}

  it {should validate_presence_of(:instruction)}

  it {should validate_length_of(:instruction)}

  it("upcases the recipe name") do
    recipe = Recipe.create({:name => 'sandwhich', :instruction => 'cook'})
    expect(recipe.name()).to(eq('SANDWHICH'))
  end
end
