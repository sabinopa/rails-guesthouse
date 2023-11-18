class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :store_guest_location!, if: :guest_not_authenticated?

  protected

  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname])
  end

  private

  def store_guest_location!
    store_location_for(:guest, request.fullpath)
  end

  def guest_not_authenticated?
    !guest_signed_in?
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location = stored_location_for(:guest)
    stored_location || super
  end
end

