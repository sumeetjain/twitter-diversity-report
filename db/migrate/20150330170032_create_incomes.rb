class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|

      t.timestamps
    end
  end
end
