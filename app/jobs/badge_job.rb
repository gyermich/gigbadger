class BadgeJob

  @queue = :badge
  def self.perform(task)
    task.workers.each do |user|
      case user.tasks.count
      when  1  ; user.add_badge(4)
      when  5  ; user.add_badge(5)
      when  10 ; user.add_badge(6)
      end
    end   
  end
end