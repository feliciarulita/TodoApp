require "rails_helper"

RSpec.describe "Tasks", type: :system do
  subject { page }

  before do
    driven_by(:rack_test)
  end


  context "when creating a task" do
    before do
      visit new_task_path
      fill_in "Name", with: "Task 1"
      fill_in "Create time", with: "2025-09-30T15:00"
      fill_in "End time", with: "2025-10-01T18:00"
      select "Pending", from: "Status"
      select "High", from: "Priority"
      fill_in "Tag", with: "Work"
      click_button "Create Task"
    end

    it { is_expected.to have_content("Task was successfully created.") }
    it { is_expected.to have_content("Task 1") }
  end

  context "when viewing tasks list" do
    before do
      create(:task, name: "Task 2", status: :pending, priority: :medium)
      visit root_path
    end

    it { is_expected.to have_content("Tasks") }
    it { is_expected.to have_content("Task 2") }
  end

  context "when updating a task" do
    let!(:task) { create(:task, name: "Task 3", status: :pending, priority: :low) }

    before do
      visit edit_task_path(task)
      fill_in "Name", with: "Updated Task 3"
      select "In progress", from: "Status"
      select "High", from: "Priority"
      click_button "Update Task"
    end

    it { is_expected.to have_content("Task was successfully updated.") }
    it { is_expected.to have_content("Updated Task 3") }
  end

  context "when deleting a task" do
    let!(:task) { create(:task, name: "Task 4", status: :pending, priority: :medium) }

    before do
      visit task_path(task)
      click_button "Delete task"
    end

    it { is_expected.to have_content("Task was successfully deleted.") }
    it { is_expected.not_to have_content("Task 4") }
  end
end
