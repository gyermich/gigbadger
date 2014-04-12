class ChangeUserTaskAcceptField < ActiveRecord::Migration
  def change
    remove_column   :user_tasks, :accept, :boolean

    add_column      :user_tasks, :accept, :string, default: :pending
  end
end
