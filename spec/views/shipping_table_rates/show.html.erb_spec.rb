require 'rails_helper'

RSpec.describe "shipping_table_rates/show", type: :view do
  before(:each) do
    @shipping_table_rate = assign(:shipping_table_rate, ShippingTableRate.create!(
      :country => "Country",
      :a => "9.99",
      :b => "9.99",
      :c => "9.99",
      :d => "9.99",
      :e => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
