class RemoveColumnFromEthnicity < ActiveRecord::Migration
  def change
    remove_column :ethnicities, :TEXT
  end
end
