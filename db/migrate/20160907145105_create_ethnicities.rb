class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :value

      t.timestamps null: false
    end
  end
end
