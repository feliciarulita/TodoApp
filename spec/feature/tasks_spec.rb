require "rails_helper"

RSpec.describe "Tasks", type: :system do
  subject { page }

  before do
    driven_by(:rack_test)
  end


  context "when creating a task" do
    before do
      visit new_task_path
      fill_in I18n.t("activerecord.attributes.task.name"), with: "Task 1"
      fill_in I18n.t("activerecord.attributes.task.create_time"), with: "2025-09-30T15:00"
      fill_in I18n.t("activerecord.attributes.task.end_time"), with: "2025-10-01T18:00"
      select I18n.t("activerecord.attributes.task.statuses.pending"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      fill_in I18n.t("activerecord.attributes.task.tag"), with: "Work"
      click_button I18n.t("todo.addTask")
    end

    it { is_expected.to have_content(I18n.t("notice.createSuccess")) }
    it { is_expected.to have_content("Task 1") }
  end

  context "when viewing tasks list" do
    before do
      create(:task, name: "Task 2", status: :pending, priority: :medium)
      visit root_path
    end

    it { is_expected.to have_content(I18n.t("todo.title")) }
    it { is_expected.to have_content("Task 2") }
  end

  context "when updating a task" do
    let!(:task) { create(:task, name: "Task 3", status: :pending, priority: :low) }

    before do
      visit edit_task_path(I18n.locale, task)
      fill_in I18n.t("activerecord.attributes.task.name"), with: "Updated Task 3"
      select I18n.t("activerecord.attributes.task.statuses.in_progress"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      click_button I18n.t("todo.updateTask")
    end

    it { is_expected.to have_content(I18n.t("notice.updateSuccess")) }
    it { is_expected.to have_content("Updated Task 3") }
  end

  context "when deleting a task" do
    let!(:task) { create(:task, name: "Task 4", status: :pending, priority: :medium) }

    before do
      visit task_path(I18n.locale, task)
      click_button I18n.t("todo.deleteTask")
    end

    it { is_expected.to have_content(I18n.t("notice.deleteSuccess")) }
    it { is_expected.not_to have_content("Task 4") }
  end

  context "when sorting tasks by create_time ascending" do
    let!(:task_first) { create(:task, name: "Task 1", create_time: "2025-09-30T10:00", status: :pending, priority: :low) }
    let!(:task_second) { create(:task, name: "Task 2", create_time: "2025-10-2T10:00", status: :pending, priority: :low) }

    before do
      visit root_path
      select I18n.t("activerecord.attributes.task.create_time"), from: "sort"
      select I18n.t("activerecord.attributes.task.ascending"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 1 to appear before Task 2" do
      expect(page.body.index(task_first.name)).to be < page.body.index(task_second.name)
    end
  end

  context "when sorting tasks by create_time descending" do
    let!(:task_first) { create(:task, name: "Task 1", create_time: "2025-09-30T10:00", status: :pending, priority: :low) }
    let!(:task_second) { create(:task, name: "Task 2", create_time: "2025-10-2T10:00", status: :pending, priority: :low) }

    before do
      visit root_path
      select I18n.t("activerecord.attributes.task.create_time"), from: "sort"
      select I18n.t("activerecord.attributes.task.descending"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 2 to appear before Task 1" do
      expect(page.body.index(task_second.name)).to be < page.body.index(task_first.name)
    end
  end
end
