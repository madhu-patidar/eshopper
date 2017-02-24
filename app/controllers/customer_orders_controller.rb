class CustomerOrdersController < ApplicationController
  include CartItemsHelper

  before_action :authenticate_customer!
  before_action :set_customer_order, only: [ :payment, :cancel_order]
  before_action :set_invoice_amount, only: [:invoice, :order_detail]

  # GET /customer_orders
  # GET /customer_orders.json
  def index
    @customer_orders = current_customer.customer_orders
  end

def create
    @cart_sub_total, @shipping_cost, @tax, @discount, @amount = amount(current_customer)

     @customer_order = CustomerOrder.find_by(status: "pending", customer_id: current_customer.id )
   if @customer_order.present?
      @customer_order.update(:customer_id => current_customer.id, :address_id =>params[:address_id], :status=> "pending", :grand_total => @amount, :shipping_charges => @shipping_cost)
      redirect_to payment_customer_order_path(@customer_order)
    else
      @customer_order = CustomerOrder.new(:customer_id => current_customer.id, :address_id => params[:address_id], :status=> "pending", :grand_total => @amount, :shipping_charges => @shipping_cost)
      @customer_order.save
      redirect_to payment_customer_order_path(@customer_order)
    end

    end 
  end
  
  def cancel_order
    @transaction = OnlineTransaction.where(customer_id: current_customer.id, customer_order_id: @customer_order.id).first
    transaction = @transaction.transaction_id
    charge = Stripe::Charge.retrieve(transaction)
    charge.refund
    @customer_order.status = "cancel"
    @customer_order.save
    @customer_order.order_details.each do |item|
        item.product.quantity += item.quantity
        item.product.save
    end
    OrderMailer.order_cancel_email(current_customer, @customer_order).deliver
  end

  def invoice
  end

  def order_detail
  end

  def payment
    @cart_items = current_customer.cart_items
    @cart_sub_total, @shipping_cost, @tax, @discount, @total = amount(current_customer)
    @amount = @total
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


  def set_invoice_amount
    if !current_customer.customer_orders.pluck(:id).include?(params[:id].to_i)
      redirect_to root_path
    else
      @discount = 0
      tax_percent = 1
      @order_sub_total = 0
      @customer_order = CustomerOrder.find(params[:id])
      used_coupon = UsedCoupon.find_by(customer_order_id: @customer_order.id, customer_id: current_customer.id)
      if used_coupon.present?
        coupon = Coupon.find(used_coupon.coupon_id)
      end

      @customer_order.order_details.each do |item|
        @order_sub_total += item.quantity*item.product.price
      end

      if coupon.present?
        @discount =  (@order_sub_total*coupon.percent_off)/100
      end

    @shipping_cost = 0
    if  @order_sub_total > 2500
      @shipping_cost = 50
    end

    @shipping_cost1 = @shipping_cost
    
    if @shipping_cost == 0
      @shipping_cost1 = "Free"
    end

    @tax = (@order_sub_total*tax_percent)/100
    @total = @order_sub_total + @shipping_cost + @tax - @discount
    end

  end

