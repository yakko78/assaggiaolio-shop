class BillingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart

  belongs_to :shipping_table_rate

  validates :firstname, :lastname, :address, :zip, :city, :province, :shipping_table_rate_id, :email, presence: true

end
