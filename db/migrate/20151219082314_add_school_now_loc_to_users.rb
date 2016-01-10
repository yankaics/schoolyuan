class AddSchoolNowLocToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_now_loc, :string
  end
end
