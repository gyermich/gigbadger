class AddDefaultsToTaskTable < ActiveRecord::Migration
  def change
    change_column :tasks, :num_workers, :integer, default: 1
    change_column :tasks, :paid, :boolean, default: false
    change_column :tasks, :status, :string, default: "active"
  end
end
