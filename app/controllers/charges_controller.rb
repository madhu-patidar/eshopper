class ChargesController < ApplicationController
  before_action :set_amount, only: [:new, :create]

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
    :amount      => @amount.to_i,
    :description => 'Rails Stripe customer',
    :currency    => 'inr'
  )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
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
end

