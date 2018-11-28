class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :material_name
      t.string :quantity
      t.integer :material_num
      t.integer :recipe_id

      t.timestamps
    end
  end
end
