class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :completed
  helper_method :errors_to_message_string

  def errors_to_message_string(errors)
    message_wrapper = "<ul class='devise-error-message'>"
    message = ''
    errors.each_with_index do |(key, error_message), index|
      field = (key.to_s == 'custom' || key.to_s == 'password_confirmation') ? '' : key.to_s
      message += "<li> #{field.camelize} #{error_message} </li>"
    end
    message_wrapper + message + '</ul>'
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, warning: 'You need to sign in before access'
    end
  end

  def redirect_url
    if warden_message == :unconfirmed
      redirect root_path
    else
      super
    end
  end

end
