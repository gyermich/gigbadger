class AddTaskPaidStatusAndChangePayColumn < ActiveRecord::Migration
  def change
    rename_column :tasks, :pay, :pay_float
    add_column :tasks, :pay, :decimal

    Task.reset_column_information
    Task.find_each { |e| e.update_attribute(:pay, e.pay_float) }
    remove_column :tasks, :pay_float

    add_column :tasks, :is_paid, :boolean, default: false
  end
end
