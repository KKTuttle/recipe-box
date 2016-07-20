class DropIngredientTagIdColumns < ActiveRecord::Migration
  def change
    remove_column(:recipes, :ingredient_id, :integer)
    remove_column(:recipes, :tag_id, :integer)
  end
end
