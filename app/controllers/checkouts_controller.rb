class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:edit, :update, :destroy]
  before_action :authenticate_customer!
  before_action :set_amount, only: [:index, :review_payment]

  # GET /checkouts
  # GET /checkouts.json
  def index
    @customer_addresses = current_customer.addresses.last(3)
    @address = Address.new
    @checkouts = Checkout.all
  end

  # GET /checkouts/1
  # GET /checkouts/1.json
  def show
  end

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
  end

  def review_payment
    @address = Address.find(params[:address_id])
  end
  # GET /checkouts/1/edit
  def edit
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)
    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout, notice: 'Checkout was successfully created.' }
        format.json { render :show, status: :created, location: @checkout }
      else
        format.html { render :new }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkouts/1
  # PATCH/PUT /checkouts/1.json
  def update
    respond_to do |format|
      if @checkout.update(checkout_params)
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkout_params
      params.fetch(:checkout, {})
    end

    def set_amount
      @cart_sub_total,@cart_sub_total = 0,0
      @cart_items = current_customer.cart_items
      @shipping_cost = 0
      @shipping_cost1 = @shipping_cost
      
      if @shipping_cost == 0
        @shipping_cost1 = "Free"
      end
      
      @cart_items.each_with_index do |item,index|
        @cart_sub_total += item.quantity*item.product.price
      end
      
      @tax = (@cart_sub_total*1)/100
      @total = @cart_sub_total + @shipping_cost + @tax
  end
end
