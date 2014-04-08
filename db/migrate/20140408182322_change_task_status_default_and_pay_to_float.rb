class ChangeTaskStatusDefaultAndPayToFloat < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :string, default: "pending"
    change_column :tasks, :pay, :float 
  end
end
