class CustomerOrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer_order, only: [:show, :edit, :update, :destroy, :payment,:cancel_order]
  before_action :set_amount, only: [:payment, :create]

  # GET /customer_orders
  # GET /customer_orders.json
  def index
    @customer_orders = current_customer.customer_orders
  end

  # GET /customer_orders/1
  # GET /customer_orders/1.json
  def show
  end

  def payment
  end

  def invoice
     @customer_order = CustomerOrder.find(params[:id])
     @order_sub_total = 0
      @customer_order.order_details.each do |item|
        @order_sub_total += item.quantity*item.product.price
      end
      @shipping_cost = 0
      @shipping_cost1 = @shipping_cost
      
      if @shipping_cost == 0
        @shipping_cost1 = "Free"
      end

      @tax = (@order_sub_total*1)/100
      @total = @order_sub_total + @shipping_cost + @tax
  end
  # GET /customer_orders/new
  def new
    @customer_order = CustomerOrder.new
  end

  # GET /customer_orders/1/edit
  def edit
  end

  def cancel_order
    @customer_order.status = "cancel"
    @customer_order.save
    @customer_order.order_details.each do |item|
        item.product.quantity += item.quantity
        item.product.save
    end
  end

  # POST /customer_orders
  # POST /customer_orders.json
  def create
   if CustomerOrder.find_by(status: "pending").present?
      @customer_order = CustomerOrder.find_by(status: "pending")

      @customer_order.update(:customer_id => current_customer.id, :address_id =>params[:address_id], :status=> "pending", :grand_total => @amount, :shipping_charges => @shipping_cost)
      redirect_to payment_customer_order_path(@customer_order)
    else
      @customer_order = CustomerOrder.new(:customer_id => current_customer.id, :address_id =>params[:address_id], :status=> "pending", :grand_total =>@amount, :shipping_charges => @shipping_cost)
      @customer_order.save
      redirect_to payment_customer_order_path(@customer_order)
    end
    end 
  end

  # PATCH/PUT /customer_orders/1
  # PATCH/PUT /customer_orders/1.json
  def update
    respond_to do |format|
      if @customer_order.update(customer_order_params)
        format.html { redirect_to @customer_order, notice: 'Customer order was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_order }
      else
        format.html { render :edit }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_orders/1
  # DELETE /customer_orders/1.json
  def destroy
    @customer_order.destroy
    respond_to do |format|
      format.html { redirect_to customer_orders_url, notice: 'Customer order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_order
      @customer_order = CustomerOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_order_params
      params.require(:customer_order).permit(:customer_id, :address_id, :status, :grand_total, :shipping_charges)
    end

  def set_amount
    @cart_sub_total,@cart_sub_total = 0,0
    @cart_items = current_customer.cart_items
      
    @cart_items.each_with_index do |item,index|
      @cart_sub_total += item.quantity*item.product.price
    end
    @shipping_cost = 0
    @shipping_cost1 = @shipping_cost
    
    if @shipping_cost == 0
      @shipping_cost1 = "Free"
    end

    @tax = (@cart_sub_total*1)/100
    @amount = @cart_sub_total + @shipping_cost + @tax
  end

