class EmailJob

  @queue = :email
  def self.perform(user, task)
    UserMailer.offer_accepted(user, task).deliver
  end
end