class ShippingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart
end
