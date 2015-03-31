class CreatePolymorphicTable < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :answer_id
      t.text 
    end
  end
end
