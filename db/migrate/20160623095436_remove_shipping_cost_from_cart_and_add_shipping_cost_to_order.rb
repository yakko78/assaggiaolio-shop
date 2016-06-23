class RemoveShippingCostFromCartAndAddShippingCostToOrder < ActiveRecord::Migration
  def change
    remove_column :carts, :shipping_cost
    add_column :orders, :shipping_cost, :decimal
  end
end
