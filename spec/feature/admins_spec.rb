require "rails_helper"

RSpec.describe "Admins", type: :system do
  subject { page }

  let!(:admin) { create(:admin) }

  before do
    driven_by(:rack_test)
    visit root_path
    fill_in :email, with: admin.email
    fill_in "password", with: "123"
    click_button User.human_attribute_name(:login)
  end

  context "when login to admin, there is User Management button" do
    it { is_expected.to have_content(I18n.t("todo.userManager")) }
  end

  context "when visiting User Management page" do
    before do
      click_link I18n.t("todo.userManager")
    end

    it { is_expected.to have_content(I18n.t("todo.adminTitle")) }
    it { is_expected.to have_content(I18n.t("todo.addUser")) }
    it { is_expected.to have_selector("table.users-list") }
  end

  context "when creating a user" do
    before do
      visit new_admin_path
      fill_in User.human_attribute_name(:name), with: "New User 1"
      fill_in User.human_attribute_name(:email), with: "newuser1@gmail.com"
      fill_in User.human_attribute_name(:password), with: "123"
      click_button I18n.t("todo.addUser")
    end

    it { is_expected.to have_content(I18n.t("notice.createUserSuccess")) }
    it { is_expected.to have_content("New User 1") }
  end

  context "when creating a user, name is blank" do
    before do
      visit new_admin_path
      fill_in User.human_attribute_name(:name), with: ""
      fill_in User.human_attribute_name(:email), with: "newuser1@gmail.com"
      fill_in User.human_attribute_name(:password), with: "123"
      click_button I18n.t("todo.addUser")
    end

    it { is_expected.to have_content("Name can't be blank") }
  end

  context "when creating a user, email already exist" do
    let!(:user) { create(:user) }

    before do
      visit new_admin_path
      fill_in User.human_attribute_name(:name), with: "New User"
      fill_in User.human_attribute_name(:email), with: user.email
      fill_in User.human_attribute_name(:password), with: "123"
      click_button I18n.t("todo.addUser")
    end

    it { is_expected.to have_content("email has already been taken") }
  end

  context "when viewing user detail page" do
    let!(:task) { create(:task, user: admin) }

    before do
      visit admin_path(I18n.locale, admin)
    end

    it { is_expected.to have_content("email : #{admin.email}") }
    it { is_expected.to have_content("Role : Admin") }
    it { is_expected.to have_content(admin.tasks.count) }
    it { is_expected.to have_content(task.name) }
  end

  context "when updating a user" do
    let!(:user) { create(:user) }

    before do
      visit edit_admin_path(I18n.locale, user)
      fill_in User.human_attribute_name(:name), with: "Update #{user.name}"
      click_button I18n.t("todo.updateUser")
    end

    it { is_expected.to have_content(I18n.t("notice.updateUserSuccess")) }
    it { is_expected.to have_content("Update #{user.name}") }
  end

  context "when updating a user, name is blank" do
    let!(:user) { create(:user) }

    before do
      visit edit_admin_path(I18n.locale, user)
      fill_in User.human_attribute_name(:name), with: ""
      click_button I18n.t("todo.updateUser")
    end

    it { is_expected.to have_content("Name can't be blank") }
  end

  context "when deleting the only admin" do
    before do
      visit admin_path(I18n.locale, admin)
      click_button I18n.t("todo.deleteUser")
    end

    it { is_expected.to have_content(I18n.t("notice.deleteUserFail")) }
  end
end
