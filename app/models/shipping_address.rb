class ShippingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart

  belongs_to :shipping_table_rate

  validates :firstname, :lastname, :address, :zip, :city, :province, :telephone, :shipping_table_rate_id, presence: true

end
