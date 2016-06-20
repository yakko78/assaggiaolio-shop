class AddCapacityFlozToProducts < ActiveRecord::Migration
  def change
    add_column :products, :capacity_floz, :decimal
  end
end
