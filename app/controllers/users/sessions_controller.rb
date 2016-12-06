class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  skip_before_filter :verify_authenticity_token, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      resource = User.find_for_database_authentication(email: params[:user][:email])

      if resource.present? && resource.valid_password?(params[:user][:password]) && resource.confirmed_at.present?
        sign_in :user, resource
        format.json { render json: {success: true, redirect_path: after_sign_in_path_for(resource)} }
      else
        format.json { render json: {success: false, message: 'Invalid Email or Password'} }
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: {success: false, message: flash[:alert]}
  end

end
