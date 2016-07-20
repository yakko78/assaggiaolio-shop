class Product < ActiveRecord::Base
  translates :title, :description, :fallbacks_for_empty_translations => true

  active_admin_translates :title, :description
end
