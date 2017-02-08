class CustomerMailer < ApplicationMailer
  default from: 'madhusudan@eshopper.com'
 
  def welcome_email(customer)
    @customer = customer
    @url  = 'http://madhu-eshopper/heroku.com/login'
    # attachments["rails.png"] = File.read("/home/webwerks/Assignments/training/ROR/live_project/eshopper/app/assets/images/home/logo.png")
    mail(to: @customer.email, subject: 'Welcome to My Awesome Site')
  end
end
