require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :sku => 1,
      :title => "MyString",
      :description => "MyText",
      :capacity_floz => "9.99",
      :height => "9.99",
      :diameter => "9.99",
      :price => "9.99",
      :capacity_cl => "9.99"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_sku[name=?]", "product[sku]"

      assert_select "input#product_title[name=?]", "product[title]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_capacity_floz[name=?]", "product[capacity_floz]"

      assert_select "input#product_height[name=?]", "product[height]"

      assert_select "input#product_diameter[name=?]", "product[diameter]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_capacity_cl[name=?]", "product[capacity_cl]"
    end
  end
end
