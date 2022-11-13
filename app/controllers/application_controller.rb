class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger
  
  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end
  
  rescue_from SecurityError do |exception|
    redirect_to root_url
  end

  protected

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
