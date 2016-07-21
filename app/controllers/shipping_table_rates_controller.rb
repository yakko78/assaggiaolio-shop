class ShippingTableRatesController < ApplicationController
  before_action :set_shipping_table_rate, only: [:show, :edit, :update, :destroy]

  # GET /shipping_table_rates
  # GET /shipping_table_rates.json
  def index
    @shipping_table_rates = ShippingTableRate.all
  end

  # GET /shipping_table_rates/1
  # GET /shipping_table_rates/1.json
  def show
  end

  # GET /shipping_table_rates/new
  def new
    @shipping_table_rate = ShippingTableRate.new
  end

  # GET /shipping_table_rates/1/edit
  def edit
  end

  # POST /shipping_table_rates
  # POST /shipping_table_rates.json
  def create
    @shipping_table_rate = ShippingTableRate.new(shipping_table_rate_params)

    respond_to do |format|
      if @shipping_table_rate.save
        format.html { redirect_to @shipping_table_rate, notice: 'Shipping table rate was successfully created.' }
        format.json { render :show, status: :created, location: @shipping_table_rate }
      else
        format.html { render :new }
        format.json { render json: @shipping_table_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_table_rates/1
  # PATCH/PUT /shipping_table_rates/1.json
  def update
    respond_to do |format|
      if @shipping_table_rate.update(shipping_table_rate_params)
        format.html { redirect_to @shipping_table_rate, notice: 'Shipping table rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipping_table_rate }
      else
        format.html { render :edit }
        format.json { render json: @shipping_table_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_table_rates/1
  # DELETE /shipping_table_rates/1.json
  def destroy
    @shipping_table_rate.destroy
    respond_to do |format|
      format.html { redirect_to shipping_table_rates_url, notice: 'Shipping table rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_table_rate
      @shipping_table_rate = ShippingTableRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_table_rate_params
      params.require(:shipping_table_rate).permit(:country_name, :a, :b, :c, :d, :e)
    end
end
