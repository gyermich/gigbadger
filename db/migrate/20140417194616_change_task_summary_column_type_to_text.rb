class ChangeTaskSummaryColumnTypeToText < ActiveRecord::Migration
  def change
  rename_column :tasks, :summary, :summary_string
  add_column :tasks, :summary, :text

  Task.reset_column_information
  Task.find_each { |t| t.update_attribute(:summary, t.summary_string) }
  remove_column :tasks, :summary_string
  end
end
