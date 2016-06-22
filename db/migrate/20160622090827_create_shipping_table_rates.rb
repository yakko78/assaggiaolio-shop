class CreateShippingTableRates < ActiveRecord::Migration
  def change
    create_table :shipping_table_rates do |t|
      t.string :country
      t.decimal :a
      t.decimal :b
      t.decimal :c
      t.decimal :d
      t.decimal :e

      t.timestamps null: false
    end
  end
end
