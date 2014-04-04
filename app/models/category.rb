class Category < ActiveRecord::Base
  has_many :tasks 
  has_many :users, through: :user_categories
  has_many :user_categories
  has_many :tasks, through: :task_categories
  has_many :task_categories
end
