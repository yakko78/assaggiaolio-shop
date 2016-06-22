class RemoveColumnEmailFromShippingAddress < ActiveRecord::Migration
  def change
    remove_column :shipping_addresses, :email
  end
end
