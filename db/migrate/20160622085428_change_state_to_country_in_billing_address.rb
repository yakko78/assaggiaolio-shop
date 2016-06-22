class ChangeStateToCountryInBillingAddress < ActiveRecord::Migration
  def change
    rename_column :billing_addresses, :state, :country
  end
end
