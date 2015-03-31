class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|

      t.timestamps
    end
  end
end
