class ChangeDataType < ActiveRecord::Migration
  def change
    change_column :users, :twitter_id, :integer, limit: 8
  end
end
