class ChangeSkuToStringInProducts < ActiveRecord::Migration
  def change
    change_column(:products, :sku, :string)
  end
end
