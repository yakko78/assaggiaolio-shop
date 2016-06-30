class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]

  def index
    session[:temporary_shipping_cost] = nil
    @products = Product.all
  end

  def loader

    require 'open-uri'
    res = open("http://www.enricoquerci.it/temp/spedizioni.json")
    temp = JSON.load(res)
    spedizioni = temp.map do |t|
      {
        "country" => t["country"].to_s.titleize,
        "a" => t["a"].to_d,
        "b" => t["b"].to_d,
        "c" => t["c"].to_d,
        "d" => t["d"].to_d,
        "e" => t["e"].to_d
      }
    end


    ShippingTableRate.destroy_all

    spedizioni.each do |t|

      pippo = ShippingTableRate.new
      pippo.country = t["country"]
      pippo.a = t["a"]
      pippo.b = t["b"]
      pippo.c = t["c"]
      pippo.d = t["d"]
      pippo.e = t["e"]
      pippo.save
    end

    redirect_to store_url

  end

end
