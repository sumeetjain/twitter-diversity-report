class DropBridgeTables < ActiveRecord::Migration
  def change
    drop_table :ages_users
    drop_table :educations_users
    drop_table :incomes_users
  end
end
