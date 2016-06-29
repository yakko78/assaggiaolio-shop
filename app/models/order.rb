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
      cmd: "_cart",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: "AO" + Time.now.to_i.to_s,
      custom: id,
      # amount: self.amount_to_pay,
      currency_code: "EUR",
      shipping_1: self.shipping_cost,
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }

    self.line_items.each_with_index do |line_item, index|
      item_name_key = "item_name_#{(index+1).to_s}"
      item_name_value = line_item.product.title

      amount_key = "amount_#{(index+1).to_s}"
      amount_value = line_item.product.price

      quantity_key = "quantity_#{(index+1).to_s}"
      quantity_value = line_item.quantity

      values[item_name_key] = item_name_value
      values[amount_key] = amount_value
      values[quantity_key] = quantity_value
    end

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

  def update_old_mysql_db
    require 'uri'
    require 'net/http'

    url = "http://www.assaggiaolio.com/new_cart_hook.php"

    params = {
      firstname: self.billing_address.firstname,
      lastname: self.billing_address.lastname,
      address: self.billing_address.address,
      zip: self.billing_address.zip,
      city: self.billing_address.city,
      province: self.billing_address.province,
      telephone: self.billing_address.telephone,
      email: self.billing_address.email,

      shipping_cost: self.shipping_cost,

      totale: self.amount_to_pay.to_s,
      trackID: self.track_id,
      tranID: self.transaction_id,
      resucode: self.status

      # Il vecchio paymentID non lo passo, perchè PayPal non lo restituisce
      # L'ID della transazione (pagamento) è in tranID
     }

    self.line_items.each_with_index do |line_item, index|
      codice_prod_key = "codice_prod_#{(index+1).to_s}"
      codice_prod_value = line_item.product.sku

      costo_prod_key = "costo_prod_#{(index+1).to_s}"
      costo_prod_value = line_item.product.price

      quantita_key = "quantita_#{(index+1).to_s}"
      quantita_value = line_item.quantity

      params[codice_prod_key] = codice_prod_value
      params[costo_prod_key] = costo_prod_value
      params[quantita_key] = quantita_value
    end

    Net::HTTP.post_form(URI.parse(url), params)

  end

end
