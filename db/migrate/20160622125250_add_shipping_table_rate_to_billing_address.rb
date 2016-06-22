class AddShippingTableRateToBillingAddress < ActiveRecord::Migration
  def change
    add_reference :billing_addresses, :shipping_table_rate, index: true, foreign_key: true
    remove_column :billing_addresses, :country
  end
end
