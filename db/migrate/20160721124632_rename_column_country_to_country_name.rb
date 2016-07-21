class RenameColumnCountryToCountryName < ActiveRecord::Migration
  def change
    rename_column :shipping_table_rates, :country, :country_name
  end
end
