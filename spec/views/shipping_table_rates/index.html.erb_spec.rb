require 'rails_helper'

RSpec.describe "shipping_table_rates/index", type: :view do
  before(:each) do
    assign(:shipping_table_rates, [
      ShippingTableRate.create!(
        :country => "Country",
        :a => "9.99",
        :b => "9.99",
        :c => "9.99",
        :d => "9.99",
        :e => "9.99"
      ),
      ShippingTableRate.create!(
        :country => "Country",
        :a => "9.99",
        :b => "9.99",
        :c => "9.99",
        :d => "9.99",
        :e => "9.99"
      )
    ])
  end

  it "renders a list of shipping_table_rates" do
    render
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
