class ChargesController < ApplicationController
  before_action :set_amount, only: [:new, :create, :payment_success]


  def new  
  end

  def create
    # Amount in cents
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount.to_i*100,
      :description => 'Rails Stripe customer',
      :currency    => 'inr'
    )
  #
    if params[:stripeToken].present?
      @customer_order = CustomerOrder.find_by(status: "pending",customer_id: current_customer.id)
      @customer_order.status = "succesfully"
      
      @customer_order.save
      current_customer.cart_items.each do |item|
        OrderDetail.create(customer_order_id: @customer_order.id, product_id: item.product.id, quantity: item.quantity, amount: item.quantity*item.product.price)
        item.product.quantity -= item.quantity
        item.product.save 
        item.destroy
      end
      # OrderMailer.order_email(current_customer, @customer_order).deliver
  end

  redirect_to payment_success_charge_path(@customer_order)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    
    redirect_to new_charge_path
  end

  def payment_success
     @customer_order = CustomerOrder.find(params[:id])
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_order
      @customer_order = CustomerOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_order_params
      params.permit()
    end
end

