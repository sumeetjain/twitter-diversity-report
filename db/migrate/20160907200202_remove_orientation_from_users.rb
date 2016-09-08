class RemoveOrientationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :orientation
  end
end
