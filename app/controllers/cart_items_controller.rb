class CartItemsController < ApplicationController
  include CartItemsHelper

  before_action :authenticate_customer!
  before_action :set_cart_item, only: [ :edit,  :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = current_customer.cart_items
    @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
  end

  def create
    quantity = 1

    @product = Product.find(params[:product_id])
    @cart_item = CartItem.find_by(product_id: params[:product_id], customer_id: current_customer.id)
    
    if @cart_item.present?
      @cart_item.quantity += quantity
    else
      @cart_item = CartItem.new(product_id: params[:product_id], customer_id: current_customer.id, quantity: quantity)
    end

    wish_list = WishList.find_by(product_id: params[:product_id])
    if wish_list.present?
      @wish_list = wish_list
    end

    respond_to do |format|
      if @cart_item.save
        @cart_items = CartItem.where(customer_id: current_customer.id)
        format.html { redirect_to :back }
        format.js
        format.json { render :back, status: :created, location: @cart_item }
      else
        format.html { render :back }
        format.json { render json: @coustomer.errors, status: :unprocessable_entity }
      end
    end

  end
  

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    quantity = 1
    @cart_item = CartItem.find(params[:id])
    @product = Product.find(params[:product_id])
    
    if params.include?(:quantity)
      current_quantity = params[:quantity].to_i
      previous_quantity =  @cart_item.quantity
      quantity = current_quantity - previous_quantity
    end
    
    if params[:qty] == "minus" 
        @cart_item.quantity -= quantity
    elsif params[:qty] == "plus"
        @cart_item.quantity += quantity
    else
       @cart_item.quantity += quantity
    end

    respond_to do |format|
      if @cart_item.save
        @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)

        format.html { redirect_to :back, notice: 'Cart item was successfully updated.' }
        format.js
        format.json { render :back, status: :ok, location: @cart_item }
      else
        format.html { render :back }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    @cart_items = current_customer.cart_items
    @product = @cart_item.product
    @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)

    respond_to do |format|
      format.html { redirect_to cart_item_url, notice: 'Cart item was successfully destroyed.' }
      format.js { render :layout => false, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
    
end
