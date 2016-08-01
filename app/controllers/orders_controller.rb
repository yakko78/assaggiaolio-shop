class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :calculate_shipping]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }, except: [:hook, :hook_triveneto]

protect_from_forgery except: [:hook, :hook_triveneto]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Il tuo carrello è vuoto"
      return
    end

    @order = Order.new
    @order.build_billing_address
    @order.billing_address.build_shipping_table_rate
    @order.build_shipping_address
    @order.shipping_address.build_shipping_table_rate

    @shipping_table_rates = ShippingTableRate.order(:country_name)

  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if params[:ship_same_address]
      @shipping_attributes = order_params[:billing_address_attributes].except!(:email, :vat)
    else
      @shipping_attributes = order_params[:shipping_address_attributes]
    end

    # BILLING
    @billing_address = BillingAddress.new(order_params[:billing_address_attributes])
    if @billing_address.valid?
      @order.billing_address = @billing_address
    end

    # SHIPPING
    @shipping_address = ShippingAddress.new(@shipping_attributes)
    if @shipping_address.valid?
      @order.shipping_address = @shipping_address
    end

    @order.add_line_items_from_cart(@cart)
    @order.total = @order.amount_to_pay

    # Se il pagamento con Consorzio Triveneto fallisce, non mi viene ritornato
    # l'ID dell'ordine fallito (così da poterlo cancellare). L'unico modo è
    # contrassegnare a priori un ordine Triveneto come NON PAGATO. Se il pagamento
    # fallisce, rimane comunque contrassegnato.

    if @order.pay_type == "2" #Carta di Credito
      @order.status = "ORDINE NON VALIDO - Pagamento non ricevuto"
    end

    respond_to do |format|
      if @order.save

        Cart.destroy(session[:cart_id])
        session[:temporary_shipping_cost] = nil
        session[:cart_id] = nil

        if @order.pay_type == "1" #PayPal
          format.html { redirect_to @order.paypal_url(order_path(@order)) }
        else #Carta di Credito
          format.html { redirect_to @order.pay_triveneto(order_path(@order)) }
        end

      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calculate_shipping
    shipping_table_rate_id = params[:id]
    @temporary_shipping_cost = @cart.calculate_shipping_cost(shipping_table_rate_id)
    session[:temporary_shipping_cost] = @temporary_shipping_cost
    shipping_table_rate = ShippingTableRate.find(shipping_table_rate_id)
    @new_country = shipping_table_rate.country_name

    respond_to do |format|
        format.js
    end
  end

  def hook
     params.permit! # Permit all Paypal input params
     status = params[:payment_status]

     if status == "Completed"

       custom = (Rack::Utils.parse_nested_query params[:custom]).symbolize_keys

       @order = Order.find custom[:id]
       @order.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], track_id: params[:invoice], purchased_at: Time.now

      #  @order.update_old_mysql_db

       # Invio email
       I18n.with_locale custom[:locale] do
         UserNotifier.send_receipt_email(@order).deliver_now
       end

     end
     render nothing: true
   end

   def hook_triveneto
     params.permit! # Permit all Consorzio Triveneto input params
     result = params[:result]

     if result == "APPROVED"
       @order = Order.find params[:udf1]
       @order.update_attributes notification_params: params, status: result, transaction_id: params[:tranid], track_id: params[:trackid], purchased_at: Time.now

      #  @order.update_old_mysql_db

       # Invio email
       I18n.with_locale params[:udf2].to_sym do
         UserNotifier.send_receipt_email(@order).deliver_now
       end

       render text: "REDIRECT=#{Rails.application.secrets.app_host}/orders/#{@order.id}"
       return
     else

       # SE LO STATUS È ERRORE, cancella l'ordine
       render nothing: true
       # meglio sarebbe
       # head 200
     end
   end

   def error
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:pay_type, :total, :shipping_cost, :notes, :ship_same_address, billing_address_attributes: [:firstname, :lastname, :company, :address, :zip, :city, :province, :shipping_table_rate_id, :telephone, :email, :vat, :order_id, :cart_id], shipping_address_attributes: [:firstname, :lastname, :company, :address, :zip, :city, :province, :shipping_table_rate_id, :telephone, :email])
      # params.require(:order).permit(:pay_type)
    end
end
