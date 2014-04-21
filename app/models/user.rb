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
  validates_presence_of :name
  validates_format_of :zipcode,
                      with: /^\d{5}(-\d{4})?$/,
                      allow_blank: true,
                      message: "should be in the form 12345 or 12345-1234",
                      multiline: true
  validates_format_of :city,
                      with: /^[a-zA-Z]*$/,
                      message: 'Only letters are allowed',
                      allow_blank: true,
                      multiline: true
  letsrate_rateable
  letsrate_rater
  acts_as_messageable

  has_many :pending_tasks, -> { where "user_tasks.status = 'pending'"},
           through: :user_tasks,
           source: :task

  has_many :accepted_tasks, -> { where "user_tasks.status = 'accept'"},
           through: :user_tasks,
           source: :task

  has_many :rejected_tasks, -> { where "user_tasks.status = 'reject'"},
           through: :user_tasks,
           source: :task


  def slug
    name.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

  def completed_tasks
    accepted_tasks.where(status: "completed")
  end

  # def name
  #   return email
  # end

  def mailboxer_email(object)
    return nil
  end
end
