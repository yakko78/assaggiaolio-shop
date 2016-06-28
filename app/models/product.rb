class Product < ActiveRecord::Base
  translates :title, :description
end
