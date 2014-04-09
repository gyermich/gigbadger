class Message < ActiveRecord::Base
  has_one :sender, class_name: "User"
  has_one :recipient, class_name: "User"

  
end
