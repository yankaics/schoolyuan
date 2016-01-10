class AddSchoolNowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_now, :string
  end
end
