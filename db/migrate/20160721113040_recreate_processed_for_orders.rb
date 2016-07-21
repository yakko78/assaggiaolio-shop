class RecreateProcessedForOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :processed
    add_column :orders, :processed, :boolean, :null=>false, :default => false
  end
end
