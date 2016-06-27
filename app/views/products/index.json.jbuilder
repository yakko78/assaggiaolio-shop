json.array!(@products) do |product|
  json.extract! product, :id, :sku, :title, :description, :capacity_floz, :height, :diameter, :price, :capacity_cl
  json.url product_url(product, format: :json)
end
