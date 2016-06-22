class AddShippingTableRateRefToShippingAddress < ActiveRecord::Migration
  def change
    add_reference :shipping_addresses, :shipping_table_rate, index: true, foreign_key: true
  end
end
