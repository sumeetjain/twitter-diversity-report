class AddFieldsIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :amount, :integer
    add_column :incomes, :user_id, :integer
  end
end
