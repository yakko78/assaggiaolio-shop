class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]

  def index
    session[:temporary_shipping_cost] = nil
    @products = Product.all
  end
end
