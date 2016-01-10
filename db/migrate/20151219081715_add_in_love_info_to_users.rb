class AddInLoveInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :in_love_info, :boolean
  end
end
