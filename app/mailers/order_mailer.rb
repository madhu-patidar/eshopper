class OrderMailer < ApplicationMailer
  default from: 'madhupatidar909@gmail.com'
 
  def order_email(customer, customer_order)
    @customer = customer
    @customer_order = customer_order
    @order_sub_total = 0
    @customer_order.order_details.each do |item|
      @order_sub_total += item.quantity*item.product.price
    end
    @shipping_cost = 0
    @shipping_cost1 = @shipping_cost
    
    if @shipping_cost == 0
      @shipping_cost1 = "Free"
    end

    @tax = (@order_sub_total*1)/100
    @total = @order_sub_total + @shipping_cost + @tax
   
    @url  = 'http://madhu-eshopper.herokuapp.com/customers'
    attachments.inline["logo.png"] = File.read("app/assets/images/home/logo.png")
    mail(to: @customer.email, subject: 'Successfully Order placed')

  end

  def order_cancel_email(customer, customer_order)
    @customer = customer
    @customer_order = customer_order
    @order_sub_total = 0
    @customer_order.order_details.each do |item|
      @order_sub_total += item.quantity*item.product.price
    end
    @shipping_cost = 0
    @shipping_cost1 = @shipping_cost
    
    if @shipping_cost == 0
      @shipping_cost1 = "Free"
    end

    @tax = (@order_sub_total*1)/100
    @total = @order_sub_total + @shipping_cost + @tax
   
    @url  = 'http://madhu-eshopper.herokuapp.com/customers'
    attachments.inline["logo.png"] = File.read("app/assets/images/home/logo.png")
    mail(to: @customer.email, subject: 'Successfully Order placed')
    
  end
end
    
  