class CustomerMailer < ApplicationMailer
  default from: 'madhusudan@eshopper.com'
 
  def welcome_email(customer)
    @customer = customer
    @url  = 'http://example.com/login'
    mail(to: @customer.email, subject: 'Welcome to My Awesome Site')
  end
end
