module CartItemsHelper
  
   def amount(current_customer)
    cart_sub_total, discount = 0,0
    tax_percent = 1
    current_customer.cart_items.each do |item|
      cart_sub_total += item.quantity*item.product.price
    end
    shipping_cost = 0
    if  cart_sub_total > 2500
      shipping_cost = 50
    end

    shipping_cost1 = shipping_cost
    
    if shipping_cost == 0
      shipping_cost1 = "Free"
    end

    if session[:applied_coupon].present?
      coupon = Coupon.find_by(code: session[:applied_coupon])
      discount = (cart_sub_total*coupon.percent_off)/100
    end
    
    tax = (cart_sub_total*tax_percent)/100
    total = cart_sub_total + shipping_cost + tax -  discount

    return cart_sub_total, shipping_cost1, tax, discount, total
  end
end
