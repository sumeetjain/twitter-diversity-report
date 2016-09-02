class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_id
      t.integer :age
      t.integer :income
      t.string :education
      t.string :ethnicity
      t.string :gender
      t.string :orientation
      t.timestamps null: false
    end
  end
end
