require 'rails_helper'

RSpec.describe "shipping_addresses/show", type: :view do
  before(:each) do
    @shipping_address = assign(:shipping_address, ShippingAddress.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Province/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Telephone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
