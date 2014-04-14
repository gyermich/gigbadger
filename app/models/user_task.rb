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

  def update_status_accept
    self.update(status: "accept")
    Notice.new([self.user], "accept_offer", self.task)
    UserTask.reject_offers(self.task)
  end

  def self.reject_offers(task)
    offers = UserTask.pending_offers_for_task(task)
    UserTask.send_reject_notices(offers, task)
    offers.map { |offer| offer.update(status: "reject")}
  end

  def self.send_reject_notices(offers, task)
    badgers = []
    offers.each { |offer| badgers << offer.user }
    Notice.new(badgers, "reject_offers", task)
  end
end
