class CreateCategories < ActiveRecord::Migration[5.2]
  def change
  	# create_table :categories, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    create_table :categories do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
