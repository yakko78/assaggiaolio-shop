class BillingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart

  validates :firstname, :lastname, :address, :zip, :city, :province, :country, presence: true

end
