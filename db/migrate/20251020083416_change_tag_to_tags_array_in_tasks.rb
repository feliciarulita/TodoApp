class ChangeTagToTagsArrayInTasks < ActiveRecord::Migration[8.0]
  # rubocop:disable Rails/ReversibleMigration
  def change
    change_table :tasks, bulk: true do |t|
      t.remove :tag
      t.string :tags, array: true, default: [], null: false
    end
  end
  # rubocop:enable Rails/ReversibleMigration
end
