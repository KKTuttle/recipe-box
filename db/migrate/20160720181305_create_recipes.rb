class CreateRecipes < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:ingredient_id, :integer)
      t.column(:tag_id, :integer)
      t.column(:instruction, :string)
      t.column(:rating, :integer)

      t.timestamps
    end
  end
end
