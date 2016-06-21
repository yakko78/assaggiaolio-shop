json.array!(@shipping_addresses) do |shipping_address|
  json.extract! shipping_address, :id, :firstname, :lastname, :company, :address, :zip, :city, :province, :state, :telephone, :email, :order_id, :cart_id
  json.url shipping_address_url(shipping_address, format: :json)
end
