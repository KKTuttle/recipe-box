require("spec_helper")

describe(Ingredient) do
  it { should have_and_belong_to_many(:recipes) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name) }

  it("capitalizes the ingredient") do
    ingredient = Ingredient.create({:name => 'bacon'})
    expect(ingredient.name()).to(eq('Bacon'))
  end
end
