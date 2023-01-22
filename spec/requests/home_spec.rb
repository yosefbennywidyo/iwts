require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "redirect wrong page to root" do
      get "/wrong"
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end
end
