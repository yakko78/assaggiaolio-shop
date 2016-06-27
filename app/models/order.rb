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
      first_name: self.shipping_address.firstname,
      last_name: self.shipping_address.lastname,
      address1: self.shipping_address.address,
      zip: self.shipping_address.zip,
      city: self.shipping_address.city,
      email: self.billing_address.email,
      cmd: "_xclick",
      uplaod: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id + Time.now.to_i.to_s,
      amount: self.amount_to_pay,
      currency_code: "EUR",
      item_name: "Nome articolo da pagare",
      item_number: '1',
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }

    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  def pay_triveneto(return_path)
    require 'uri'
    require 'net/http'

    params = {
      id: "11115604",
      password: "Francesco71",
      action: "4",
      amt: self.amount_to_pay.to_s,
      currencycode: "978",
      udf1: id.to_s,
      langid: "ITA",
      responseURL: "#{Rails.application.secrets.app_host}/hook_triveneto",
      errorURL: "#{Rails.application.secrets.app_host}/error",
      trackid: "AO" + Time.now.to_i.to_s
    }

    url = 'https://www.constriv.com/cg/servlet/PaymentInitHTTPMobileServlet'

    test = Net::HTTP.post_form(URI.parse(url), params)

    returnValue = test.body.split(':https://')
    finalURL = 'https://'+returnValue[1]+'?PaymentID='+returnValue[0]

    finalURL

  end

end
