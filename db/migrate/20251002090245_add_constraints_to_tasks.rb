class AddConstraintsToTasks < ActiveRecord::Migration[8.0]
  def change
    change_column :tasks, :name, :string, limit: 100, null: false
    change_column_null :tasks, :status, false
    change_column_null :tasks, :priority, false
    change_column_null :tasks, :create_time, false
    add_check_constraint :tasks, "end_time > create_time", name: "end_after_create"
  end
end
