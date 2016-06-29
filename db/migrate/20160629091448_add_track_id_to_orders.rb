class AddTrackIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :track_id, :string
  end
end
