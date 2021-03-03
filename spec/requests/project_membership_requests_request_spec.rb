require 'rails_helper'

RSpec.describe "ProjectMembershipRequests", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/project_membership_requests/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_membership_requests/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
