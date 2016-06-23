class RemoveBillingAddressRefFromCart < ActiveRecord::Migration
  def change
    remove_reference :carts, :billing_address, index: true, foreign_key: true
  end
end
