class AddExpectedLoverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :expected_lover, :text
  end
end
