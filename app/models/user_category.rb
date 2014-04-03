class UserCategory < ActiveRecord::Base
  belongs_to :user 
  belongs_to :category

  # Do we need this? When would user belong to category?
end
