class OrderMailer < ApplicationMailer
  default from: 'madhupatidar909@gmail.com'
 
  def order_email(customer, customer_order)
    @customer = customer
    @customer_order = customer_order
    @url  = 'http://example.com/login'
    attachments.inline["logo.png"] = File.read("assets/images/home/logo.png")
    mail(to: @customer.email, subject: 'Successfully Order placed')
  end
end
