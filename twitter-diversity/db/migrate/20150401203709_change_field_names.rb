class ChangeFieldNames < ActiveRecord::Migration
  def change
    rename_column :educations, :level_attained, :value
    rename_column :ages, :birth_year, :value
    rename_column :incomes, :amount, :value
  end
end
