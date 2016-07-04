class AddEmailToShippingAddress < ActiveRecord::Migration
  def change
    add_column :shipping_addresses, :email, :string
  end
end
