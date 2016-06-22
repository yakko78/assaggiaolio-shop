class ShippingTableRate < ActiveRecord::Base
  has_many :shipping_addresses
end
