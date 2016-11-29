class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :none_closeable, :close_ten_seconds
  helper_method :errors_to_message_string

  def errors_to_message_string(errors)
    total_errors = errors.count
    message_first = "There #{'is'.pluralize(total_errors)} #{'error'.pluralize(total_errors)} in"
    message_second = ' '
    message_intermediate = " and #{'reason'.pluralize(total_errors)} #{'is'.pluralize(total_errors)} "
    message_third = ' '
    message_final = '. Please try again...'
    errors.each_with_index do |( key, error_message), index|
      if index == 0
        message_second += key.to_s.upcase
        message_third += key.to_s.upcase + ' ' + "'#{ error_message.to_s }'"
      elsif index != 0 && total_errors - 1 == index
        message_second += " and #{key.to_s.upcase}"
        message_third += " and '#{key.to_s.upcase}' '#{error_message.to_s}'"
      else
        message_second += ", #{key.to_s.upcase}"
        message_third += ", #{key.to_s.upcase} '#{error_message.to_s}'"
      end
    end
    message_first + message_second + message_intermediate + message_third + message_final
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, warning: 'You need to sign in before access'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
