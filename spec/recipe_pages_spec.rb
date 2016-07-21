require("spec_helper")

describe("Recipe path", {:type => :feature}) do
  it("allows users to view new recipe page") do
    visit("/")
    click_link("Add a New Recipe")
    expect(page).to have_content("Add a New Recipe")
  end

  it("allows users to add ingredients") do
    visit("/recipes/new")
    fill_in("ingredient_name", :with => "Onion")
    click_button("Add Ingredient")
    expect(page).to have_content("Onion")
  end

  it("allows users to add recipe name, choose ingredients and create instructions") do
    Ingredient.create(:name => "Onion")
    Ingredient.create(:name => "Garlic")
    Ingredient.create(:name => "Pasta")
    visit("/recipes/new")
    fill_in("recipe_name", :with => "Pasta Sauce")
    check("Onion")
    check("Garlic")
    check("Pasta")
    fill_in("instructions", :with => "Cook")
    click_button("Create Recipe")
    expect(page).to have_content("PASTA SAUCE")
  end

  it("allows users to see all recipes") do
    Recipe.create({:name => "Sandwhich", :instruction => "Make it"})
    visit("/recipes")
    expect(page).to have_content("SANDWHICH")
  end

  it("allows users to view a recipe") do
    Recipe.create({:name => "Sandwhich", :instruction => "Make it"})
    visit("/recipes")
    click_link('SANDWHICH')
    expect(page).to have_content("SANDWHICH")
  end

  it('allows users to edit the recipe') do
    Recipe.create({:name => "Sandwhich", :instruction => "Make it"})
    visit("/recipes")
    click_link('SANDWHICH')
    fill_in('recipe_name', :with => 'BLT')
    click_button('Update')
    expect(page).to have_content('BLT')
  end

  it('allows the user to add tags to the recipe') do
    tag = Tag.create({:name => 'Easy'})
    recipe = Recipe.create({:name => "Sandwhich", :instruction => "Make it"})
    visit("/recipes")
    click_link('SANDWHICH')
    check('Easy')
    click_button('Add Tag')
    expect(page).to have_content('Easy')
  end
end
