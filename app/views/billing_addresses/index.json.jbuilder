json.array!(@billing_addresses) do |billing_address|
  json.extract! billing_address, :id, :firstname, :lastname, :company, :address, :zip, :city, :province, :state, :telephone, :email, :vat, :order_id, :cart_id
  json.url billing_address_url(billing_address, format: :json)
end
