class AddFinalEduSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :final_edu_school, :string
  end
end
