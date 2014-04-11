module ApplicationHelper

  def avatar(user)
    if user.image_url.nil?
      "/profile.jpg"
    else
      user.image_url(:preview).to_s
    end
  end
end
