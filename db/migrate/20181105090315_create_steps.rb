class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    # create_table :steps, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    create_table :steps do |t|
      t.integer :procedure_num
      t.string :procedure
      t.string :details
      t.string :recipe_id
      t.string :step_image_id

      t.timestamps
    end
  end
end
