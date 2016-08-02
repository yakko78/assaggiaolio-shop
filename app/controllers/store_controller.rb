class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]

  def index
    session[:temporary_shipping_cost] = nil
    @products = Product.all
  end

  def letsencrypt
    # use your code here, not mine
    render text: "GZyYG5ixjqA2J5Qiyl-ri00bBK7yjhsjTVHMfzl5sX0"
  end
end
