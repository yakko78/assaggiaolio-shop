class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy

  accepts_nested_attributes_for :billing_address, allow_destroy: true
  accepts_nested_attributes_for :shipping_address, allow_destroy: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def amount_to_pay
    partial = line_items.to_a.sum { |item| item.total_price }
    partial += self.shipping_cost unless self.shipping_cost.blank?
  end

  def paypal_url(return_path)
    values = {
      business: "stuff-facilitator@yellowtulip.it",
      cmd: "_xclick",
      uplaod: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: self.amount_to_pay,
      item_name: "Nome articolo da pagare",
      item_number: '1',
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }

    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
