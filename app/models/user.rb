class User < ActiveRecord::Base
  has_merit


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
  acts_as_messageable

  # def name
  #   return email
  # end

  def mailboxer_email(object)
    return nil
  end
end
