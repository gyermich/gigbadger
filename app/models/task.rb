class Task < ActiveRecord::Base
  has_many    :users, through: :user_tasks
  has_many    :user_tasks
  has_many    :categories, through: :task_categories
  has_many    :task_categories
  belongs_to  :owner, class_name: "User"

end
