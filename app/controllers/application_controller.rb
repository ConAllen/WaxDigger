class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  #the below code is taken from the devise github page is enables a name field
  #to be added to the sign page and the edit profile page
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
