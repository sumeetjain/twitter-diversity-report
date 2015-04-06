class UserIncomeBridge < ActiveRecord::Migration
  def change
    create_table :incomes_users do |t|
      t.integer :income_id
      t.integer :user_id
    end
  end
end
