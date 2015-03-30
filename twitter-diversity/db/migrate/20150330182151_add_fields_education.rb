class AddFieldsEducation < ActiveRecord::Migration
  def change
    add_column :educations, :level_attained, :text
    add_column :educations, :user_id, :integer
  end
end
