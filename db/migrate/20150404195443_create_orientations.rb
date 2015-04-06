class CreateOrientations < ActiveRecord::Migration
  def change
    create_table :orientations do |t|
      t.string :value

      t.timestamps
    end
  end
end
