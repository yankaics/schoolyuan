class AddEduFinishedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :edu_finished, :string
  end
end
