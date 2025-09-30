class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :create_time
      t.datetime :end_time
      t.string :status, default: "Pending"
      t.string :priority
      t.string :tag

      t.timestamps
    end
  end
end
