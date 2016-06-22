require "rails_helper"

RSpec.describe ShippingTableRatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shipping_table_rates").to route_to("shipping_table_rates#index")
    end

    it "routes to #new" do
      expect(:get => "/shipping_table_rates/new").to route_to("shipping_table_rates#new")
    end

    it "routes to #show" do
      expect(:get => "/shipping_table_rates/1").to route_to("shipping_table_rates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shipping_table_rates/1/edit").to route_to("shipping_table_rates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shipping_table_rates").to route_to("shipping_table_rates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shipping_table_rates/1").to route_to("shipping_table_rates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shipping_table_rates/1").to route_to("shipping_table_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shipping_table_rates/1").to route_to("shipping_table_rates#destroy", :id => "1")
    end

  end
end
