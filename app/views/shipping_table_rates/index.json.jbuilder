json.array!(@shipping_table_rates) do |shipping_table_rate|
  json.extract! shipping_table_rate, :id, :country, :a, :b, :c, :d, :e
  json.url shipping_table_rate_url(shipping_table_rate, format: :json)
end
