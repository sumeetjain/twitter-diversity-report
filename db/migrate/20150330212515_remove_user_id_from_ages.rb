class RemoveUserIdFromAges < ActiveRecord::Migration
  def up
    remove_column :ages, :user_id
  end

  def down
    add_column :ages, :user_id, :integer
  end
end
