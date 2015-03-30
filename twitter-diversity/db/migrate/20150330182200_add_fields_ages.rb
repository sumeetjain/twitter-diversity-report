class AddFieldsAges < ActiveRecord::Migration
  def change
    add_column :ages, :birth_year, :integer
    add_column :ages, :user_id, :integer
  end
end
