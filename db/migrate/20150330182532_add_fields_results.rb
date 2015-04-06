class AddFieldsResults < ActiveRecord::Migration
  def change
    add_column :results, :searched_handle, :text
    add_column :results, :education, :text
    add_column :results, :income, :text
    add_column :results, :age, :text
  end
end

