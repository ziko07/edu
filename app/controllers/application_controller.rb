class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def errors_to_message_string(errors)
    total_errors = errors.count
    message_first = total_errors > 1 ? 'There are errors in' : 'There is a error in'
    message_second = " "
    message_intermediate = total_errors > 1 ? ' and reasons are ' : ' and reason is '
    message_third = " "
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
end
