class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_one :billing_address, dependent: :destroy

  accepts_nested_attributes_for :billing_address, reject_if: proc { |b| b[:firstname].blank? }
  validates_associated :billing_address

  def add_product(product_id, quantity)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = line_items.build(product_id: product_id)
      current_item.quantity = quantity
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
