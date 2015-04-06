class UserAgeBridge < ActiveRecord::Migration
  def change
    create_table :ages_users do |t|
      t.integer :age_id
      t.integer :user_id
    end
  end
end
