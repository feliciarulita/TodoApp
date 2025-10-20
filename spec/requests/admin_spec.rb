require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /index" do
    let!(:admin) { create(:admin) }

    before { sign_in_as(admin) }

    it "returns http success" do
      get admin_users_path

      expect(response).to have_http_status(:success)
    end
  end
end
