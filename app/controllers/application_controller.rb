class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :log_current_action

  # TODO (smolnar) use locales for message, refactor
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message

    redirect_to root_url
  end

  protected

  include Concerns::Logging
  include Concerns::Flash

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit :login, :email, :password, :password_confirmation }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit :email, :password, :password_confirmation, :current_password }
  end

  # TODO (smolnar) resolve
  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
