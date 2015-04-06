class ChangeResultTable < ActiveRecord::Migration
  def change
    remove_column :results, :age
    remove_column :results, :income
    rename_column :results, :education, :demo_hash
  end
end
