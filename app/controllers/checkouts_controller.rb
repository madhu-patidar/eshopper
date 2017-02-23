class CheckoutsController < ApplicationController
  include CheckoutsHelper
  include CartItemsHelper

  before_action :authenticate_customer!
  before_action :set_checkout, only: [:edit, :update, :destroy]

  def index
    @customer_addresses = current_customer.addresses
    @address = Address.new
  end

  def review_payment
    @address = Address.find(params[:address_id])
    review(params)
    @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
  end

end
