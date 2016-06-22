require 'rails_helper'

RSpec.describe "shipping_table_rates/new", type: :view do
  before(:each) do
    assign(:shipping_table_rate, ShippingTableRate.new(
      :country => "MyString",
      :a => "9.99",
      :b => "9.99",
      :c => "9.99",
      :d => "9.99",
      :e => "9.99"
    ))
  end

  it "renders new shipping_table_rate form" do
    render

    assert_select "form[action=?][method=?]", shipping_table_rates_path, "post" do

      assert_select "input#shipping_table_rate_country[name=?]", "shipping_table_rate[country]"

      assert_select "input#shipping_table_rate_a[name=?]", "shipping_table_rate[a]"

      assert_select "input#shipping_table_rate_b[name=?]", "shipping_table_rate[b]"

      assert_select "input#shipping_table_rate_c[name=?]", "shipping_table_rate[c]"

      assert_select "input#shipping_table_rate_d[name=?]", "shipping_table_rate[d]"

      assert_select "input#shipping_table_rate_e[name=?]", "shipping_table_rate[e]"
    end
  end
end
