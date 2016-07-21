class Product < ActiveRecord::Base
  translates :title, :description, :fallbacks_for_empty_translations => true
  globalize_accessors :locales => [:en, :es, :it], :attributes => [:title, :description]
  active_admin_translates :title, :description
end
