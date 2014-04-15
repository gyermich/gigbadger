require 'notice'

class BadgeJob

  @queue = :badge
  def self.perform(id)
    # Resque only accepts simple objects - string, integer, hash, array
    task = Task.find(id)
    task.workers.each do |user|
      case user.tasks.count
      when  1  ; user.add_badge(4) ; Notice.new([user], "badge", task)
      when  5  ; user.add_badge(5) ; Notice.new([user], "badge", task)
      when  10 ; user.add_badge(6) ; Notice.new([user], "badge", task)
      end
    end   
  end
end