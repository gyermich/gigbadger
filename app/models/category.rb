class Category < ActiveRecord::Base
  has_many :tasks 
  # Do we need below users with categories?
  has_many :users, through: :user_categories
  has_many :user_categories
  # do we need below relationship?
  has_many :tasks, through: :task_categories
  has_many :task_categories
end
