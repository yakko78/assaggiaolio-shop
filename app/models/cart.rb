class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

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

  def calculate_shipping_cost(shipping_table_rate_id)
    if !shipping_table_rate_id.nil?
      shipping_table_rate = ShippingTableRate.find(shipping_table_rate_id)
      total_quantity = line_items.to_a.sum { |item| item.quantity }

      result = case total_quantity
      when 1..15 then shipping_table_rate.a
      when 16..26 then shipping_table_rate.b
      when 37..72 then shipping_table_rate.c
      when 73..136 then shipping_table_rate.d
      when 137..198 then shipping_table_rate.e
      else 0
      end

      result
    end
  end

  def total_price
    partial = line_items.to_a.sum { |item| item.total_price }
    # partial += self.shipping_cost unless self.shipping_cost.blank?

    partial

  end
end
