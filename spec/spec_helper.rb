ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Ingredient.all().each() do |ingredient|
      ingredient.destroy()
    end
    Tag.all().each() do |tag|
      tag.destroy()
    end
    Recipe.all().each() do |recipe|
      recipe.destroy()
    end
  end
end
