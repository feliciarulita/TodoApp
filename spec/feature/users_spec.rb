require "rails_helper"

RSpec.describe "Users", type: :system do
  subject { page }

  before do
    driven_by(:rack_test)
  end

  context "when sign up new user" do
    before do
      visit signup_path
      fill_in :user_name, with: "New User"
      fill_in :email, with: "newuser@gmail.com"
      fill_in :user_password, with: "123"
      fill_in :user_password_confirmation, with: "123"
      click_button User.human_attribute_name(:signUp)
    end

    it { is_expected.to have_content(I18n.t("notice.registrationSuccess")) }
  end

  context "when sign up new user, name is blank" do
    before do
      visit signup_path
      fill_in :user_name, with: ""
      fill_in :email, with: "newuser@gmail.com"
      fill_in :user_password, with: "123"
      fill_in :user_password_confirmation, with: "123"
      click_button User.human_attribute_name(:signUp)
    end

    it { is_expected.to have_content("Name can't be blank") }
  end

  context "when login to existing user" do
    let!(:user) { create(:user) }

    before do
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button User.human_attribute_name(:login)
    end

    it { is_expected.to have_content("#{I18n.t('todo.welcome')}, #{user.name} !") }
  end

  context "when log out" do
    let!(:user) { create(:user) }

    before do
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button User.human_attribute_name(:login)
      click_button User.human_attribute_name(:logout)
    end

    it { is_expected.to have_content(I18n.t("notice.logoutSuccess")) }
  end
end
