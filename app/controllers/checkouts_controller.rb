class CheckoutsController < ApplicationController
  include CheckoutsHelper
  include CartItemsHelper

  before_action :authenticate_customer!
  before_action :set_checkout, only: [:edit, :update, :destroy]

  def index
    @customer_addresses = current_customer.addresses
    @address = Address.new
  end

  def show
  end

  def new
    @checkout = Checkout.new
  end

  def review_payment
    review(params)
    @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
  end
 
  def edit
  end

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

  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end
    
    def checkout_params
      params.fetch(:checkout, {})
    end

end
