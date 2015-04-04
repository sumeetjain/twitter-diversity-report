class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.string :value
      t.string :TEXT

      t.timestamps
    end
  end
end
