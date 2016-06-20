class RenameColumnCapacityToCapacityCl < ActiveRecord::Migration
  def change
    rename_column(:products, :capacity, :capacity_cl)
  end
end
