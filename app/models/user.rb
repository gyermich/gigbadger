class User < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, through: :user_tasks
  has_many :user_tasks
  has_many :categories, through: :user_categories
  has_many :user_categories
  letsrate_rateable
  letsrate_rater

end
