class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
  	# create_table :favorites, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    create_table :favorites do |t|
    	t.integer :user_id
    	t.integer :group_id

      t.timestamps
    end
  end
end
