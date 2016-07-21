require("spec_helper")

describe("Tag path", {:type => :feature}) do
  it("allows users to see all tags") do
    Tag.create({:name => "Easy"})
    visit('/')
    click_link('View All Tags')
    expect(page).to have_content("Easy")
  end

  it("allows users to view a single tag page") do
    Tag.create({:name => "Easy"})
    visit('/tags')
    click_link('Easy')
    expect(page).to have_content("Easy")
  end

  it("allows users to update a tag") do
    Tag.create({:name => "Yummy"})
    visit('/tags')
    click_link('Yummy')
    fill_in("tag_name", :with => "Delicious")
    click_button('Update')
    expect(page).to have_content("Delicious")
  end

  it("allows users to delete a tag") do
    Tag.create({:name => "healthy"})
    visit('/tags')
    click_link('Healthy')
    click_button('Delete')
    expect(page).to have_no_content("Healthy")
  end
end
