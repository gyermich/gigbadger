class EmailJob

  @queue = :email
  def self.perform(user_id, task_id)
    @user = User.find(user_id)
    @task = Task.find(task_id)
    UserMailer.offer_accepted(@user, @task).deliver
  end
end