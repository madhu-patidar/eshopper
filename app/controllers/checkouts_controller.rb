class CheckoutsController < ApplicationController
  include CheckoutsHelper
  include CartItemsHelper

  before_action :authenticate_customer!
  before_action :set_checkout, only: [:edit, :update, :destroy]

  def index
    if current_customer.cart_items.count > 0
      @customer_addresses = current_customer.addresses
      @address = Address.new
    else
      redirect_to root_path
    end
  end

  def review_payment
    if current_customer.cart_items.count > 0
      @address = Address.find(params[:address_id])
      review(params)
      @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
    else
      redirect_to root_path
    end
  end

end
