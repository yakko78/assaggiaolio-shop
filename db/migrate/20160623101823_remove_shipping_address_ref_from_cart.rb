class RemoveShippingAddressRefFromCart < ActiveRecord::Migration
  def change
    remove_reference :carts, :shipping_address, index: true, foreign_key: true
  end
end
