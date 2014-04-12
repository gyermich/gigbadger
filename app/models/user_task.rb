class UserTask < ActiveRecord::Base
  belongs_to :user 
  belongs_to :task

  def self.badger_for_task?(user, task)
    UserTask.where(user_id: user.id, task_id: task.id).exists?

    # return true if UserTask.find_by(user_id: user.id, task_id: task.id) != nil
  end

  def self.pending_offers_for_task(task)
    # shows owner pending offers for task
    UserTask.where("task_id = ? AND status = ?", task.id, "pending")
  end

  def self.pending_offers_for_badger(badger)
    # shows badger pending offers they sent
    UserTask.where("user_id = ? AND status = ?", badger.id, "pending")
  end

  def self.accepted_offers_for_badger(badger)
    UserTask.where("user_id = ? AND status = ?", badger.id, "accept")
  end

  def accept_offer
    self.update(status: "accept")
    self.reject_offers(self.task.id)
  end

  def reject_offers(task)
    offers = UserTask.where("task_id = ? AND status = ?", task, "pending")

    offers.map { |offer| offer.update(status: "reject")}
  end
end
