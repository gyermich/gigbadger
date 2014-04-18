class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  def update_status_accept
    self.update(status: "accept")
    Notice.new([self.user], "accept_offer", self.task)
    UserTask.reject_offers(self.task)
  end

  def self.reject_offers(task)
    offers = task.pending_users
    UserTask.send_reject_notices(offers, task)
    offers.each do |user|
      user.user_tasks.each { |ut| ut.update(status: "reject")}
    end
  end

  def self.send_reject_notices(offers, task)
    badgers = []
    offers.each { |user| badgers << user }
    Notice.new(badgers, "reject_offers", task)
  end
end
