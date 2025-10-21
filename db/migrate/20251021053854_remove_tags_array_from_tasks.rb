class RemoveTagsArrayFromTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :tags, :string
  end
end
