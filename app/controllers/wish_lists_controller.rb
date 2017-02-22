class WishListsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_wish_list, only: [:destroy]

  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_lists = current_customer.wish_lists
  end

  def create
      @product = Product.find(params[:product_id])
      @wish_list = WishList.find_or_initialize_by(product_id: params[:product_id], customer_id: current_customer.id)

      respond_to do |format|
        if @wish_list.save
          format.html { redirect_to :back, notice: 'Wish list was successfully created.' }
          format.js
          format.json { render :show, status: :created, location: @wish_list }
        else
          format.html { render :new }
          format.json { render json: @wish_list.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    @product = Product.find(@wish_list.product_id)
    @wish_list.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Wish list was successfully destroyed.' }
      format.js 
      format.json { head :no_content }
    end
  end

  private

    def set_wish_list
      @wish_list = WishList.find(params[:id])
    end
   
end
