class ReportsController < ApplicationController
  
  before_action :authenticate_customer!
  before_action :set_admin
  before_action :set_hash

  def sale_order
    customer_success_orders = CustomerOrder.month_success_order
    customer_pending_orders = CustomerOrder.month_pending_order
    @sale_order_year = CustomerOrder.all.group_by{|u| u.created_at.strftime("%Y")}
    @success_order_month = @hash
    @pending_order_month = @hash

    customer_success_orders.each do |orders|
      if @success_order_month.keys.include?(orders[0])
        @success_order_month[orders[0]] = orders[1].count
      end
    end

    customer_pending_orders.each do |orders|
      if @pending_order_month.keys.include?(coupon[0])
        @pending_order_month[orders[0]] = orders[1].count
      end
    end
  end

  def customer_registered
     @customer_registered_year = Customer.all.group_by{|u| u.created_at.strftime("%Y")}
    registered_customer_monthly = Customer.registered_customer_monthly
    @registered_customer_monthly = @hash

    registered_customer_monthly.each do |customer|
      if @registered_customer_monthly.keys.include?(customer[0])
        @registered_customer_monthly[customer[0]] = customer[1].count
      end
    end


  end

  def coupons_used
    @used_coupons_year = UsedCoupon.all.group_by{|u| u.created_at.strftime("%Y")}

    monthly_used_coupons = UsedCoupon.monthly_used_coupons
    @monthly_used_coupons = @hash

    monthly_used_coupons.each do |coupon|
      if @monthly_used_coupons.keys.include?(coupon[0])
        @monthly_used_coupons[coupon[0]] = coupon[1].count
      end
      
    end
  end

  def set_admin
    if current_customer.admin == false
      redirect_to root_path
    end
  end
  
  def set_hash
    @year = DateTime.now.strftime("%Y")
    if params[:year].present?
      @year = params[:year]
    end
    @hash = { "#{@year} January" => 0,
              "#{@year} February" => 0,
              "#{@year} March" => 0,
              "#{@year} April" => 0,
              "#{@year} May" => 0 ,
              "#{@year} June"=> 0,
              "#{@year} July" => 0,
              "#{@year} August" => 0,
              "#{@year} September" => 0,
              "#{@year} October" => 0,
              "#{@year} November" => 0,
              "#{@year} December" => 0
            }
  end

end

