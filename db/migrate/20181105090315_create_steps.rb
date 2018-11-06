class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :procedure_num
      t.string :procedure
      t.string :details

      t.timestamps
    end
  end
end
