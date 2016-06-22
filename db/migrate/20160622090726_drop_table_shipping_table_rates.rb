class DropTableShippingTableRates < ActiveRecord::Migration
  def change
    drop_table :shipping_table_rates
  end
end
