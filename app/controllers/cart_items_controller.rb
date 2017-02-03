class CartItemsController < ApplicationController
 
  before_action :set_cart_item, only: [ :edit,  :destroy]
  before_action :authenticate_customer!

  # GET /cart_items
  # GET /cart_items.json
  def index
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
    @total = @cart_sub_total + @shipping_cost + @tax
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show

    @cart_sub_total,@cart_sub_total = 0,0
    @cart_items = CartItem.where(customer_id: current_customer.id)
    
    @cart_items.each_with_index do |item,index|
      @cart_sub_total += item.quantity*item.product.price
    end

   @tax = (@cart_sub_total*1)/100

  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create

    quantity = 1

    if params[:controller_name].present? && params[:cart_item][:quantity].present?
      quantity = params[:cart_item][:quantity].to_i
    end

    @product = Product.find(params[:product_id])

    if @product.quantity >= quantity && quantity > 0 
      @cart_item = CartItem.where(product_id: params[:product_id],customer_id:current_customer.id).first
      
      if @cart_item.present?
        @cart_item.quantity += quantity
      else
        @cart_item = CartItem.new(product_id: params[:product_id],customer_id: current_customer.id, quantity: quantity)
      end

      respond_to do |format|
        if @cart_item.save
          @product.quantity -= quantity
          # @product.save
          @cart_items = CartItem.where(customer_id: current_customer.id)
          format.html { redirect_to :back }
          format.js { }
          format.json { render :back, status: :created, location: @cart_item }
        else
          format.html { render :back }
          format.json { render json: @coustomer.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to :back
    end
  end
  

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update

    quantity, @cart_sub_total = 1,0
    @cart_item = CartItem.find(params[:id])
    @product = Product.find(params[:product_id])
    
    if params.include?(:quantity)
      qty = params[:quantity].to_i
      qty1 =  @cart_item.quantity
      quantity = qty - qty1
    end
    
    if params[:qty] == "minus" 
      if @cart_item.quantity > 1
        @cart_item.quantity -= quantity
        @product.quantity += quantity
      end

    elsif params[:qty] == "plus"
      if @product.quantity > 0
        @cart_item.quantity += quantity
        @product.quantity -= quantity
      end

    else
      if quantity > 0
        if @product.quantity >= quantity
          @cart_item.quantity = @cart_item.quantity + quantity
          @product.quantity -= quantity
        end
      else 
          @cart_item.quantity +=  quantity
          @product.quantity -= quantity
      end

    end

    respond_to do |format|
      if @cart_item.save
        # @product.save
        @cart_items = CartItem.where(customer_id: current_customer.id)

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
        @total = @cart_sub_total + @shipping_cost + @tax

        format.html { redirect_to :back, notice: 'Cart item was successfully updated.' }
        format.js { }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_sub_total = 0
    @product = Product.find(@cart_item.product_id)
    @product.quantity += @cart_item.quantity
    @cart_item.destroy
    @product.save
    @cart_items = current_customer.cart_items
      
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
    @total = @cart_sub_total + @shipping_cost + @tax

    respond_to do |format|
      format.html { redirect_to cart_item_url, notice: 'Cart item was successfully destroyed.' }
      format.js { render :layout => false, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      # params.fetch(:cart_item, {})
      params.require(:cart_item).permit(:customer_id, :product_id, :quantity)
    end
end
