class RemoveUserIdFromEducations < ActiveRecord::Migration
  def up
    remove_column :educations, :user_id
  end

  def down
    add_column :educations, :user_id, :integer
  end
end
