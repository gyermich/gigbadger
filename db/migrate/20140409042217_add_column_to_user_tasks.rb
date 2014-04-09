class AddColumnToUserTasks < ActiveRecord::Migration
  def change
    add_column :user_tasks, :accept, :boolean, default: :false
  end
end
