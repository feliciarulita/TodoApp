require "rails_helper"

RSpec.describe "Tasks", type: :system do
  subject { page }

  let!(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    visit root_path
    fill_in :email, with: user.email
    fill_in "password_digest", with: "123"
    click_button User.human_attribute_name(:login)
  end

  context "when login to created user" do
    it { is_expected.to have_content("#{I18n.t('todo.welcome')}, #{user.name} !") }
  end

  context "when creating a task" do
    before do
      visit new_task_path
      fill_in Task.human_attribute_name(:name), with: "Task 1"
      fill_in Task.human_attribute_name(:create_time), with: "2025-09-30T15:00"
      fill_in Task.human_attribute_name(:end_time), with: "2025-10-01T18:00"
      select I18n.t("activerecord.attributes.task.statuses.pending"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      fill_in Task.human_attribute_name(:tag), with: "Work"
      click_button I18n.t("todo.addTask")
    end

    it { is_expected.to have_content(I18n.t("notice.createSuccess")) }
    it { is_expected.to have_content("Task 1") }
  end

  context "when viewing tasks list" do
    let!(:task) { create(:task, user: user) }

    before do
      visit tasks_path
    end

    it { is_expected.to have_content(I18n.t("todo.title")) }
    it { is_expected.to have_content(task.name) }
  end

  context "when updating a task" do
    let!(:task) { create(:task, user: user) }

    before do
      visit edit_task_path(I18n.locale, task)
      fill_in Task.human_attribute_name(:name), with: "Updated Task 3"
      select I18n.t("activerecord.attributes.task.statuses.in_progress"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      click_button I18n.t("todo.updateTask")
    end

    it { is_expected.to have_content(I18n.t("notice.updateSuccess")) }
    it { is_expected.to have_content("Updated Task 3") }
  end

  context "when deleting a task" do
    let!(:task) { create(:task, user: user) }

    before do
      visit task_path(I18n.locale, task)
      click_button I18n.t("todo.deleteTask")
    end

    it { is_expected.to have_content(I18n.t("notice.deleteSuccess")) }
    it { is_expected.not_to have_content(task.name) }
  end

  context "when sorting tasks by create_time ascending" do
    let!(:task_first) { create(:task, user: user) }
    let!(:task_second) { create(:task, :later_create_time, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:create_time), from: "sort"
      select I18n.t("activerecord.attributes.task.asc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 1 to appear before Task 2" do
      expect(page.body.index(task_first.name)).to be < page.body.index(task_second.name)
    end
  end

  context "when sorting tasks by create_time descending" do
    let!(:task_first) { create(:task, user: user) }
    let!(:task_second) { create(:task, :later_create_time, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:create_time), from: "sort"
      select I18n.t("activerecord.attributes.task.desc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 2 to appear before Task 1" do
      expect(page.body.index(task_second.name)).to be < page.body.index(task_first.name)
    end
  end

  context "when sorting tasks by ID ascending" do
    let!(:task_first) { create(:task, user: user) }
    let!(:task_second) { create(:task, user: user) }

    before do
      visit tasks_path
      select "ID", from: "sort"
      select I18n.t("activerecord.attributes.task.asc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 1 to appear before Task 2" do
      expect(page.body.index(task_first.name)).to be < page.body.index(task_second.name)
    end
  end

  context "when sorting tasks by ID descending" do
    let!(:task_first) { create(:task, user: user) }
    let!(:task_second) { create(:task, user: user) }

    before do
      visit tasks_path
      select "ID", from: "sort"
      select I18n.t("activerecord.attributes.task.desc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 2 to appear before Task 1" do
      expect(page.body.index(task_second.name)).to be < page.body.index(task_first.name)
    end
  end

  context "when sorting tasks by end_time descending" do
    let!(:task_first) { create(:task, :earlier_end_time, user: user) }
    let!(:task_second) { create(:task, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:end_time), from: "sort"
      select I18n.t("activerecord.attributes.task.desc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 2 to appear before Task 1" do
      expect(page.body.index(task_second.name)).to be < page.body.index(task_first.name)
    end
  end

  context "when sorting tasks by end_time ascending" do
    let!(:task_first) { create(:task, :earlier_end_time, user: user) }
    let!(:task_second) { create(:task, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:end_time), from: "sort"
      select I18n.t("activerecord.attributes.task.asc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 1 to appear before Task 2" do
      expect(page.body.index(task_first.name)).to be < page.body.index(task_second.name)
    end
  end

  context "when sorting tasks by priority descending" do
    let!(:task_first) { create(:task, :lower_priority, user: user) }
    let!(:task_second) { create(:task, :higher_priority, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:priority), from: "sort"
      select I18n.t("activerecord.attributes.task.desc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 2 to appear before Task 1" do
      expect(page.body.index(task_second.name)).to be < page.body.index(task_first.name)
    end
  end

  context "when sorting tasks by priority ascending" do
    let!(:task_first) { create(:task, :lower_priority, user: user) }
    let!(:task_second) { create(:task, :higher_priority, user: user) }

    before do
      visit tasks_path
      select Task.human_attribute_name(:end_time), from: "sort"
      select I18n.t("activerecord.attributes.task.asc"), from: "direction"
      click_button I18n.t("todo.sort")
    end

    it "expected Task 1 to appear before Task 2" do
      expect(page.body.index(task_first.name)).to be < page.body.index(task_second.name)
    end
  end

  context "when creating a task, name is blank" do
    before do
      visit new_task_path
      fill_in Task.human_attribute_name(:name), with: ""
      fill_in Task.human_attribute_name(:create_time), with: "2025-09-30T15:00"
      fill_in Task.human_attribute_name(:end_time), with: "2025-10-01T18:00"
      select I18n.t("activerecord.attributes.task.statuses.pending"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      fill_in Task.human_attribute_name(:tag), with: "Work"
      click_button I18n.t("todo.addTask")
    end

    it { is_expected.to have_content("#{Task.human_attribute_name(:name)} #{I18n.t('errors.messages.blank')}") }
  end

  context "when creating a task, create time is greater than end time" do
    before do
      visit new_task_path
      fill_in Task.human_attribute_name(:name), with: "Task 1"
      fill_in Task.human_attribute_name(:create_time), with: "2025-10-03T15:00"
      fill_in Task.human_attribute_name(:end_time), with: "2025-10-01T18:00"
      select I18n.t("activerecord.attributes.task.statuses.pending"), from: "Status"
      select I18n.t("activerecord.attributes.task.priorities.high"), from: "Priority"
      fill_in Task.human_attribute_name(:tag), with: "Work"
      click_button I18n.t("todo.addTask")
    end

    it { is_expected.to have_content(I18n.t('errors.messages.greater_than')) }
  end

  context "when searching for tasks by name" do
    let!(:task) { create(:task, user: user) }

    before do
      visit tasks_path
      fill_in "q_name_cont", with: task.name
      click_button I18n.t("todo.search")
    end

    it { is_expected.to have_content(task.name) }
  end
end
