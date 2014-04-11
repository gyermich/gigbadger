class WelcomeController < ApplicationController
  def index
    @tasks  = Task.all
    @users  = User.joins(:rate_average_without_dimension).order('rating_caches.avg DESC').first(4)
  end
end
