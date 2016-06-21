require 'rails_helper'

RSpec.describe "billing_addresses/edit", type: :view do
  before(:each) do
    @billing_address = assign(:billing_address, BillingAddress.create!(
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
      :vat => "MyString",
      :order => nil,
      :cart => nil
    ))
  end

  it "renders the edit billing_address form" do
    render

    assert_select "form[action=?][method=?]", billing_address_path(@billing_address), "post" do

      assert_select "input#billing_address_firstname[name=?]", "billing_address[firstname]"

      assert_select "input#billing_address_lastname[name=?]", "billing_address[lastname]"

      assert_select "input#billing_address_company[name=?]", "billing_address[company]"

      assert_select "textarea#billing_address_address[name=?]", "billing_address[address]"

      assert_select "input#billing_address_zip[name=?]", "billing_address[zip]"

      assert_select "input#billing_address_city[name=?]", "billing_address[city]"

      assert_select "input#billing_address_province[name=?]", "billing_address[province]"

      assert_select "input#billing_address_state[name=?]", "billing_address[state]"

      assert_select "input#billing_address_telephone[name=?]", "billing_address[telephone]"

      assert_select "input#billing_address_email[name=?]", "billing_address[email]"

      assert_select "input#billing_address_vat[name=?]", "billing_address[vat]"

      assert_select "input#billing_address_order_id[name=?]", "billing_address[order_id]"

      assert_select "input#billing_address_cart_id[name=?]", "billing_address[cart_id]"
    end
  end
end
