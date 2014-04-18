class RemoveTaskTimeFromSchema < ActiveRecord::Migration
  def change
    remove_column :tasks, :due_time
  end
end
