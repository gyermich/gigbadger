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
      badge_notification
    end
  end

  def accept_offer
    subject = "Offer accepted"
    body = "Congratulations, your offer was accepted for: <strong>#{@task.name}</strong>"
    @receivers.each do |accept|
      accept.notify(subject,body,obj = nil,sanitize_text=true,notification_code=@notification_code,send_mail=true)
    end
  end

  def reject_offers
    subject = "Offer not accepted"
    body = "We regret to inform you that the gig owner has decided to accept another badger's offer for: <strong>#{@task.name}</strong>."
    @receivers.each do |reject|
      reject.notify(subject,body,obj = nil,sanitize_text=true,notification_code=@notification_code,send_mail=true)
    end
  end

  def badge_notification
    subject = "Badge received"
    @receivers.each do |user|
      body = "Congratulations, you earned the #{user.badges.last.description} badge"
      user.notify(subject,body,obj = nil,sanitize_text=true,notification_code=@notification_code,send_mail=true)
    end
  end
end