class Task < ActiveRecord::Base
  has_many    :users, through: :user_tasks
  has_many    :user_tasks
  # throws an error on task create:
  # belongs_to  :owner_id, class_name: "User"
  belongs_to  :categories
end
