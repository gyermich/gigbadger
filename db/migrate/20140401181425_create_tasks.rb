class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :owner
      t.boolean :paid
      t.integer :pay
      t.string :status
      t.string :summary
      t.string :name
      t.date :due_date
      t.time :due_time
      t.integer :num_workers

      t.timestamps
    end
  end
end
