require 'csv'

class Populate

  def self.all
    CSV.read("./lib/badger.csv").map do |array|
      create_user(array)
    end
  end

  def self.create_user(seed_array)
    new_user = User.create(
      name: seed_array[0],
      email: seed_array[1],
      city: seed_array[2],
      zipcode: seed_array[3],
      bio: seed_array[4],
      password: seed_array[0],
      password_confirmation: seed_array[0]
    )

    create_user_category(new_user, seed_array)
    create_task(new_user,seed_array)
  end

  def self.create_user_category(new_user, seed_array)
    UserCategory.create(
      user_id: new_user.id,
      category_id: seed_array[5].to_i
      )
  end

  def self.create_task(user,seed_array)
    task = Task.create(
      # add name
      # status "available"
              owner_id: user.id,
              name: seed_array[6],  
              paid: seed_array[7],
              pay:  seed_array[8],
              status: seed_array[9],
              summary: seed_array[10],
              due_date: seed_array[11]
            )
    create_user_task(user, task)
    create_task_category(task, seed_array)
  end

  def self.create_user_task(user, task)
    UserTask.create(
      user_id: user.id,
      task_id: task.id 
      )
  end

  def self.create_task_category(task, seed_array)
    TaskCategory.create(
      task_id: task.id,
      category_id: seed_array[12].to_i
      )
  end
end