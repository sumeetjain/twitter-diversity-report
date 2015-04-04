class ChangeTwitterIdColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :twitter_id, :twitter_id_num
  end
end
