class WelcomeController < ApplicationController
  def index
    @tasks  = Task.all
  end
end
