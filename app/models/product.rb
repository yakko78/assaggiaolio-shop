class Product < ActiveRecord::Base
  validates :sku, :title, :price, presence: true
end
