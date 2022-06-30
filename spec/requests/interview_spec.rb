require 'rails_helper'

RSpec.describe "Interviews", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/interview/index"
      expect(response).to have_http_status(:success)
    end
  end

end
