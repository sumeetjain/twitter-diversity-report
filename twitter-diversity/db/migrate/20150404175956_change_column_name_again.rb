class ChangeColumnNameAgain < ActiveRecord::Migration
  def change
    rename_column :users, :twitter_id_num, :twitterid
  end
end
