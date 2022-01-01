require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /top" do
    it "returns http success" do
      get "/static_pages/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/static_pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /faq" do
    it "returns http success" do
      get "/static_pages/faq"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /inquiry" do
    it "returns http success" do
      get "/static_pages/inquiry"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /policy" do
    it "returns http success" do
      get "/static_pages/policy"
      expect(response).to have_http_status(:success)
    end
  end

end
