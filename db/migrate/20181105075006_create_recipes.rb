class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :comment
      t.integer :views, default: 1
      t.string :cook_image_id
      t.integer :category_id
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
