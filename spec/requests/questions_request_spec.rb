require 'rails_helper'

RSpec.describe "Questions", type: :request do

  describe "GET /create show" do
    it "returns http success" do
      get "/questions/create show"
      expect(response).to have_http_status(:success)
    end
  end

end
