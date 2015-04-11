class ChangeNameOfTwitteridField < ActiveRecord::Migration
  def change
    rename_column :users, :twitterid, :password_hash
  end
end
