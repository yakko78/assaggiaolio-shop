class RemoveShippingRefToShippingTr < ActiveRecord::Migration
  def change
    remove_reference :shipping_table_rates, :shipping_address, index: true, foreign_key: true
  end
end
