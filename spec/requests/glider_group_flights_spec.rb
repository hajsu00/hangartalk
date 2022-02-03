require 'rails_helper'

RSpec.describe "GliderGroupFlights", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/glider_group_flights/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/glider_group_flights/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/glider_group_flights/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/glider_group_flights/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/glider_group_flights/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/glider_group_flights/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
