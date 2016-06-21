require 'rails_helper'

RSpec.describe "shipping_addresses/edit", type: :view do
  before(:each) do
    @shipping_address = assign(:shipping_address, ShippingAddress.create!(
      :firstname => "MyString",
      :lastname => "MyString",
      :company => "MyString",
      :address => "MyText",
      :zip => 1,
      :city => "MyString",
      :province => "MyString",
      :state => "MyString",
      :telephone => "MyString",
      :email => "MyString",
      :order => nil,
      :cart => nil
    ))
  end

  it "renders the edit shipping_address form" do
    render

    assert_select "form[action=?][method=?]", shipping_address_path(@shipping_address), "post" do

      assert_select "input#shipping_address_firstname[name=?]", "shipping_address[firstname]"

      assert_select "input#shipping_address_lastname[name=?]", "shipping_address[lastname]"

      assert_select "input#shipping_address_company[name=?]", "shipping_address[company]"

      assert_select "textarea#shipping_address_address[name=?]", "shipping_address[address]"

      assert_select "input#shipping_address_zip[name=?]", "shipping_address[zip]"

      assert_select "input#shipping_address_city[name=?]", "shipping_address[city]"

      assert_select "input#shipping_address_province[name=?]", "shipping_address[province]"

      assert_select "input#shipping_address_state[name=?]", "shipping_address[state]"

      assert_select "input#shipping_address_telephone[name=?]", "shipping_address[telephone]"

      assert_select "input#shipping_address_email[name=?]", "shipping_address[email]"

      assert_select "input#shipping_address_order_id[name=?]", "shipping_address[order_id]"

      assert_select "input#shipping_address_cart_id[name=?]", "shipping_address[cart_id]"
    end
  end
end
