class ApplicationController < ActionController::Base
  include Localizable

  before_action :set_locale
    def  set_locale
      I18n.locale =  session[:locale]
    end

  protect_from_forgery prepend: true, with: :exception, unless: -> { request.format.json? }
end
