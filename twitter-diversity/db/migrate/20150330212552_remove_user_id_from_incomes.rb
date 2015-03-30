class RemoveUserIdFromIncomes < ActiveRecord::Migration
  def up
    remove_column :incomes, :user_id
  end

  def down
    add_column :incomes, :user_id, :integer
  end
end
