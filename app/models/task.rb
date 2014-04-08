class Task < ActiveRecord::Base
  has_many    :users, through: :user_tasks
  has_many    :user_tasks
  has_many    :categories, through: :task_categories
  has_many    :task_categories
  # throws an error on task create:
  # belongs_to  :owner_id, class_name: "User"
  # belongs_to :user, foreign_key: "owner_id"

  def owner
    User.find(owner_id)
  end

  def self.find_by_category(query)
    TaskCategory.where(category_id: query.id)
  end
end
