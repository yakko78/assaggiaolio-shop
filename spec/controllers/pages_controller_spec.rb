require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #termsconditions" do
    it "returns http success" do
      get :termsconditions
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #warranty" do
    it "returns http success" do
      get :warranty
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #paymentmethods" do
    it "returns http success" do
      get :paymentmethods
      expect(response).to have_http_status(:success)
    end
  end

end
