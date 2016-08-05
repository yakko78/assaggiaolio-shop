class PagesController < ApplicationController
  def termsconditions
  end

  def warranty
  end

  def paymentmethods
  end

  def test
    @order = Order.new
    @order.build_billing_address
    # @order = BillingAddress.new
  end
end
