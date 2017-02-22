class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  def render_404
    respond_to do |format|
      format.html { render partial: "home/error_404"}
      format.all { render nothing: true, status: 404 }
    end
  end
  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :remember_me, :password, :password_confirmation, :current_password, :admin]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  

end
