class Product < ActiveRecord::Base
  validates :sku, :title, :price, presence: true
  has_many :line_items
end
