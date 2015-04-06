class UserEduBridge < ActiveRecord::Migration
  def change
    create_table :educations_users do |t|
      t.integer :education_id
      t.integer :user_id
    end
  end
end
