class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]

  def index
    session[:temporary_shipping_cost] = nil
    @products = Product.all
  end

  def letsencrypt
    # use your code here, not mine
    render text: "1df1ob5ZkaLDnBaxnZPGlBYNjCU5XaVNFmSQIwPGwew.DTNxc1VFqVzjRFhtq7PqStHcbqJBVNeRnA1kJqIZdxw"
  end
end
