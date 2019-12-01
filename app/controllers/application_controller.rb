# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:icon, :name, :postal_code, :address, :profile, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:icon, :name, :postal_code, :address, :profile, :password, :password_confirmation])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
