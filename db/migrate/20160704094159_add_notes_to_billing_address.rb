class AddNotesToBillingAddress < ActiveRecord::Migration
  def change
    add_column :billing_addresses, :notes, :text
  end
end
