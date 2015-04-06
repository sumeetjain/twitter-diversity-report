class AddTwitterIdFieldToUsersTable < ActiveRecord::Migration
  def change
    
    add_column :users, :twitter_id, 'bigint'
    
  end
end
