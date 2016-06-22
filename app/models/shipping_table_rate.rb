class ShippingTableRate < ActiveRecord::Base
  has_many :billing_addresses
  has_many :shipping_addresses
end
