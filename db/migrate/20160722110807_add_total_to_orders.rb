class AddTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal, :null=>false, :default => 0
  end
end
