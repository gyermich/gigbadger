class TaskCategory < ActiveRecord::Base
  belongs_to :task 
  belongs_to :category

  def self.create_record(task, category)
    TaskCategory.create(
      task_id: task.id,
      category_id: category.id
      )
  end
end
