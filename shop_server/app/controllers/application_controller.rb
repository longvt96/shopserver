class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :set_locale

  def authenticate_user_from_token!
    user_token = params[:auth_token].presence
    user = user_token && User.find_by_authentication_token(user_token.to_s)
    if user
      sign_in user, store: false
    end
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'authentication error' }, status: 401
    end
  end

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
    payload[:ua] = request.user_agent
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :client
      new_client_session_path
    end
  end
  # Get locale depend on params locale, session locale
  # Input params locale, session locale
  # Output locale
  # def set_locale
  #   locale_browser = request.env['HTTP_ACCEPT_LANGUAGE'].blank? ? "ja" : request.env['HTTP_ACCEPT_LANGUAGE'][0,2]
  #   locale = Country::COUNTRY_LOCALE[locale_browser]
  #   if params[:locale]
  #     I18n.locale = params[:locale]
  #     session[:locale] = params[:locale]
  #   elsif session[:locale]
  #     I18n.locale = session[:locale]
  #   else
  #     I18n.locale = locale.present? ? locale : I18n.default_locale
  #   end
  # end

end
