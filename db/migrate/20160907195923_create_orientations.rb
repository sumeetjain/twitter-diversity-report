class CreateOrientations < ActiveRecord::Migration
  def change
    create_table :orientations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :value

      t.timestamps null: false
    end
  end
end
