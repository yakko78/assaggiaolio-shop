require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :sku => 1,
        :title => "Title",
        :description => "MyText",
        :capacity_floz => "9.99",
        :height => "9.99",
        :diameter => "9.99",
        :price => "9.99",
        :capacity_cl => "9.99"
      ),
      Product.create!(
        :sku => 1,
        :title => "Title",
        :description => "MyText",
        :capacity_floz => "9.99",
        :height => "9.99",
        :diameter => "9.99",
        :price => "9.99",
        :capacity_cl => "9.99"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
