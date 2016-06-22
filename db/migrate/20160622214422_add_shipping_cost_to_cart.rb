class AddShippingCostToCart < ActiveRecord::Migration
  def change
    add_column :carts, :shipping_cost, :decimal
  end
end
