class AddFieldsUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_handle, :text
  end
end
