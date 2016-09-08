class RemoveEthnicityFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :ethnicity
  end
end
