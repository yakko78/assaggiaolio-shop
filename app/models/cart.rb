class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy


  accepts_nested_attributes_for :billing_address, allow_destroy: true
  accepts_nested_attributes_for :shipping_address, allow_destroy: true

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

  def shipping_price

    # se c'è Shipping meglio, altrimenti prendo Billing

    s = shipping_address ||= billing_address

    if !s.nil?
      total_quantity = line_items.to_a.sum { |item| item.quantity }

      result = case total_quantity
      when 1..15 then s.shipping_table_rate.a
      when 16..26 then s.shipping_table_rate.b
      when 37..72 then s.shipping_table_rate.c
      when 73..136 then s.shipping_table_rate.d
      when 137..198 then s.shipping_table_rate.e
      else 0
      end

      result
    end

  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
