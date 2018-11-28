class CreateGroups < ActiveRecord::Migration[5.2]
  def change
  	# create_table :groups, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    create_table :groups do |t|
      t.string :group_name
      t.string :group_image_id
      t.boolean :lock, default: false, null: false #falseなら誰でもグループに参加できる
      t.boolean :restrict, default: false, null: false #tureならメンバーのみ閲覧できる

      t.timestamps
    end
  end
end
