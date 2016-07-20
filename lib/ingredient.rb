class Ingredient < ActiveRecord::Base
  has_many :recipes
  has_many :tags, through: :recipes
end
