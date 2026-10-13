# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home" do
  describe "GET /" do
    it "renders the public home page without signing in" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("NASA Missions", "Interplanetary fuel calculator")
      expect(response.body).not_to include("Log in", "Log out", "/admin/login")
    end
  end

  describe "GET /up" do
    it "exposes the health check without signing in" do
      get rails_health_check_path

      expect(response).to have_http_status(:ok)
    end
  end
end
