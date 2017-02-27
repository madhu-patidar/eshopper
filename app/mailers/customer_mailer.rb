class CustomerMailer < ApplicationMailer
  
  default from: 'madhusudan@eshopper.com'
 
  def welcome_email(customer)
    @customer = customer
    @url  = 'http://madhu-eshopper.herokuapp.com'
    attachments.inline["logo.png"] = File.read("app/assets/images/home/logo.png")
    mail(to: @customer.email, subject: 'Welcome to E-Shopper')
  end
  
end
