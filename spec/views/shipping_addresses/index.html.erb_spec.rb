require 'rails_helper'

RSpec.describe "shipping_addresses/index", type: :view do
  before(:each) do
    assign(:shipping_addresses, [
      ShippingAddress.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :company => "Company",
        :address => "MyText",
        :zip => 1,
        :city => "City",
        :province => "Province",
        :state => "State",
        :telephone => "Telephone",
        :email => "Email",
        :order => nil,
        :cart => nil
      ),
      ShippingAddress.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :company => "Company",
        :address => "MyText",
        :zip => 1,
        :city => "City",
        :province => "Province",
        :state => "State",
        :telephone => "Telephone",
        :email => "Email",
        :order => nil,
        :cart => nil
      )
    ])
  end

  it "renders a list of shipping_addresses" do
    render
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Province".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
