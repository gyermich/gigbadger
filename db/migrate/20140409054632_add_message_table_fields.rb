class AddMessageTableFields < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :integer
    add_column :messages, :recipient_id, :integer
    add_column :messages, :subject, :string
    add_column :messages, :body, :text
    add_column :messages, :task_id, :integer  
  end
end
