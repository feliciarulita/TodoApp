class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pagy::Backend
  allow_browser versions: :modern
  before_action :set_locale
  helper_method :current_user, :logged_in?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_user
    return @current_user if @current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to login, alert: "Please log in first" unless logged_in?
  end
end
