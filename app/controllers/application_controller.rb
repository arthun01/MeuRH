class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_tenant
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_tenant
    set_current_tenant(current_user&.company)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
