class ChangeStateToCountryInShippingAddress < ActiveRecord::Migration
  def change
    rename_column :shipping_addresses, :state, :country

  end
end
