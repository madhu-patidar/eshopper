class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @customer = Customer.from_omniauth(request.env["omniauth.auth"])

    if @customer.persisted?
      sign_in_and_redirect @customer, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_customer_registration_url
    end
  end

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @customer = Customer.from_omniauth(request.env["omniauth.auth"])
      if @customer.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @customer, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_customer_registration_url
      end
  end
  
  def twitter
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @customer = Customer.from_omniauth(request.env["omniauth.auth"])
      if @customer.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "twitter"
        sign_in_and_redirect @customer, :event => :authentication
      else
        session["devise.twitter_data"] = request.env["omniauth.auth"]
        redirect_to new_customer_registration_url
      end
  end

  def failure
    redirect_to root_path
  end
end