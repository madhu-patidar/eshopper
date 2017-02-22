class CouponsController < ApplicationController
  include CartItemsHelper
  
  def create
      @coupan = Coupon.find_by(code: params[:code])
      if @coupan.present?
        @used_coupon = UsedCoupon.find_by(customer_id: current_customer, coupon_id: @coupan.id )

        if @used_coupon.present?
          @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
          @message = "Coupon Alredy Used.."
        else
          session[:applied_coupon] = params[:code]
          @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
        end

      else
        @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
        @message = "Invalid Coupon..!!"
      end
  end

  def destroy
    @coupan = Coupon.find_by(code: params[:code])
    if @coupan.present?
      session[:applied_coupon] = nil
      @cart_sub_total, @shipping_cost1, @tax, @discount, @total = amount(current_customer)
    else
      redirect_to :back
    end
  end
end
