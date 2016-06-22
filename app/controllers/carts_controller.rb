class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :checkout]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  def pay
  end

  # GET /carts/1/edit
  def edit
    @cart.build_billing_address
    @cart.build_shipping_address
    @cart.shipping_address.build_shipping_table_rate

    @shipping_table_rates = ShippingTableRate.all
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    @shipping_tr = ShippingTableRate.find(cart_params[:shipping_address_attributes][:shipping_table_rate_id])

    # BILLING
    @billing_address = BillingAddress.new(cart_params[:billing_address_attributes])
    @billing_address.country = @shipping_tr.country
    @cart.billing_address = @billing_address

    # SHIPPING
    @shipping_address = ShippingAddress.new(cart_params[:shipping_address_attributes])
    @shipping_address.country = @shipping_tr.country
    @cart.shipping_address = @shipping_address

    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to store_url, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to store_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_cart
    #   @cart = Cart.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(billing_address_attributes: [:firstname, :lastname, :company, :address, :zip, :city, :province, :country, :telephone, :email, :vat, :order_id, :cart_id], shipping_address_attributes: [:firstname, :lastname, :company, :address, :zip, :city, :province, :shipping_table_rate_id, :telephone])
      # params.require(:billing_address).permit(:firstname, :lastname, :company, :address, :zip, :city, :province, :state, :telephone, :email, :vat, :order_id, :cart_id)
      # params.fetch(:cart, {})
    end
end
