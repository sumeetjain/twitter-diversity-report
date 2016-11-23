class ChangeEducationToEnum < ActiveRecord::Migration
  def change
  	new_values_hash = {"Elementary" => "0", "Secondary" => "1", "Post-secondary" => "2", 
  					"Graduate" => "3", "Post-graduate" => "4"}

  	User.all.each do |u|
  		if u.education == nil
  			u.education = nil
  		else
  			u.education = new_values_hash[u.education]
  		end
  		u.save
  	end

  	change_column :users, :education, 'integer USING CAST(education AS integer)'
  end
end
