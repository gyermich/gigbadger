class Task < ActiveRecord::Base
  has_many    :users, through: :user_tasks
  has_many    :user_tasks
  belongs_to  :owner, class_name: "User"

  # add category_id to schema
  belongs_to  :categories 
end
