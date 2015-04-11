class ChangeNameBackChangeLimit < ActiveRecord::Migration
  def change
    rename_column :users, :password_hash, :twitterid
    change_column :users, :twitterid, :string, :limit => nil
  end
end
