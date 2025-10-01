class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :create_time
      t.datetime :end_time
      t.integer :status, default: 0
      t.integer :priority, default: 0
      t.string :tag

      t.timestamps
    end
  end
end
