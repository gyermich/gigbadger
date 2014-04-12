class ChangeUserTaskAcceptFieldAgain < ActiveRecord::Migration
  def change
    remove_column   :user_tasks, :accept, :string

    add_column      :user_tasks, :status, :string, default: :pending
  end
end
