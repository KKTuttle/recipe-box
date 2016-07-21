class AddIndicesToForeignKeysAndRanking < ActiveRecord::Migration
  def change
    add_index :ingredients_recipes, :ingredient_id
    add_index :ingredients_recipes, :recipe_id
    add_index :recipes, :rating
    add_index :recipes_tags, :recipe_id
    add_index :recipes_tags, :tag_id
  end
end
