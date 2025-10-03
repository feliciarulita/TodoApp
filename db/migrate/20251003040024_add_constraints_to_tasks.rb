class AddConstraintsToTasks < ActiveRecord::Migration[8.0]
  def up
    change_table :tasks, bulk: true do |t|
      t.change :name, :string, limit: 100, null: false
      t.change_null :status, false
      t.change_null :priority, false
      t.change_null :create_time, false
    end

    add_check_constraint :tasks, "end_time > create_time", name: "end_after_create"
  end

  def down
    change_table :tasks, bulk: true do |t|
      t.change :name, :string, null: true
      t.change_null :status, true
      t.change_null :priority, true
      t.change_null :create_time, true
    end
  end

  remove_check_constraint :tasks, name: "end_after_create"
end
