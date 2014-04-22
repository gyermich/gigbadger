class WelcomeController < ApplicationController
  def index
    @tasks  = Task.all.order('created_at DESC').first(9)
    @users  = User.joins(:rate_average_without_dimension).order('rating_caches.avg DESC').first(4)
  end

  def about
  end
end
