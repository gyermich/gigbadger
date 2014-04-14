class Notice
    attr_accessor :receiver, :notification_code, :task

  def initialize(receivers, notification_code, task)
    @receivers = receivers
    @notification_code = notification_code
    @task = task
    
    notification_type
  end

  def notification_type
    case @notification_code
    when "accept_offer"
      accept_offer
    when "reject_offers"
      reject_offers
    when "badge"
      Badges.new(@receivers)
    end
  end

  def accept_offer
    # receipt = User.find(@receiver)
    subject = "Offer accepted"
    body = "Congratulations, your offer was accepted for #{@task.name}"
    @receivers.each do |accept|
      accept.notify(subject,body,obj = nil,sanitize_text=true,notification_code=@notification_code,send_mail=true)
    end
  end

  def reject_offers
    subject = "Offer not accepted"
    body = "We regret to inform you that the gig owner has decided to accept another badger's offer for #{@task.name}."
    @receivers.each do |reject|
      reject.notify(subject,body,obj = nil,sanitize_text=true,notification_code=@notification_code,send_mail=true)
    end
  end

end