class TaskCategory < ActiveRecord::Base
  belongs_to :task 
  belongs_to :category 

  # Do we need this table? Task would only have one category
end
