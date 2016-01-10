class AddMarriedInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :married_info, :boolean
  end
end
