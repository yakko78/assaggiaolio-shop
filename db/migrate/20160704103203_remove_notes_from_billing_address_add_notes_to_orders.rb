class RemoveNotesFromBillingAddressAddNotesToOrders < ActiveRecord::Migration
  def change
    remove_column :billing_addresses, :notes, :text
    add_column :orders, :notes, :text
  end
end
