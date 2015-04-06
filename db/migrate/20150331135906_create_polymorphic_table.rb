class CreatePolymorphicTable < ActiveRecord::Migration
  def change
    change_table :user_answers do |t|
      t.integer :user_id
      t.integer :answer_id
      t.text :answer_type
    end
  end
end
