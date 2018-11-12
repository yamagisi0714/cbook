class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :material_name
      t.string :quantity
      t.integer :recipe_id
      t.integer :unit_id

      t.timestamps
    end
  end
end
