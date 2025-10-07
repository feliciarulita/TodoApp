class AddIndexesToTasks < ActiveRecord::Migration[8.0]
  def change
    add_index :tasks, :name
    add_index :tasks, :status
    add_index :tasks, :create_time
    add_index :tasks, :end_time
  end
end
