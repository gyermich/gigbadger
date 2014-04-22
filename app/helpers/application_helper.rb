module ApplicationHelper

  def avatar(user)
    if user.nil? or user.image_url.nil?
      "/profile.jpg"
    else
      user.image_url(:preview).to_s
    end
  end

  def display_date(input_date)
    return input_date.strftime("%d %B %Y at %I:%M%p")
  end

  def display_date_only(input_date)
    return input_date.strftime("%d %B %Y")
  end
end
