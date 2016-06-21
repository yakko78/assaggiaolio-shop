class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :firstname
      t.string :lastname
      t.string :company
      t.text :address
      t.integer :zip
      t.string :city
      t.string :province
      t.string :state
      t.string :telephone
      t.string :email
      t.references :order, index: true, foreign_key: true
      t.references :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
