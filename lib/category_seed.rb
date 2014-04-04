require 'csv'

class CategorySeed

  def self.all
    CSV.read("./lib/categories.csv").map do |array|
      create_category(array)
    end
  end

  def self.create_category(category_array)
    Category.create(
      name: category_array[0]
      )
  end
# class TaskSeed

#   def self.all
#     CSV.read("./lib/badger.csv").map do |array|
#       create_task(array)
#     end
#   end

#   def self.create_task(task_array)
#     task = Task.create(
#               owner: task_array[6],  
#               paid: task_array[7],
#               pay:  task_array[8],
#               status: task_array[9],
#               summary: task_array[10],
#               due_date: task_array[11],
#               due_time: task_array[12],
#               num_workers: task_array[13],
#               category: task_array[14]
#             )

#     create_task_category(task)
#   end

#   def self.create_task_category(task)
#     TaskCategory.create(
#       task_id: task.id,
#       category_id: task.category
#       )
#   end
end