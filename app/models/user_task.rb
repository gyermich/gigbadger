class UserTask < ActiveRecord::Base
  belongs_to :user 
  belongs_to :task

  def self.badger_for_task?(user, task)
    UserTask.where(user_id: user.id, task_id: task.id).exists?
  end
end
