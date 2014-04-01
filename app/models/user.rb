class User < ActiveRecord::Base
  has_many :tasks, through: :user_tasks
  has_many :user_tasks
  has_many :categories, through: :user_categories
  has_many :user_categories
end
