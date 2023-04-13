class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from :update_allowed_parameters, if: :devise_controller?
    redirect_to root_url, alert: exception.message
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :email, :password, :bio) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :email, :password, :current_password, :bio)
    end
  end
end
