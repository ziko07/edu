class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  def create
    build_resource(sign_up_params)
    full_name = params[:user][:full_name].split(' ', 2)
    resource.first_name = full_name.first
    resource.last_name = full_name.last
    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        return render :json => {success: true, redirect_path: after_sign_up_path_for(resource)}
      else
        flash[:success] = t('devise.registrations.signed_up_but_unconfirmed')
        return render :json => {success: true, confirmation_sent: true, redirect_path: after_sign_up_path_for(resource)}
      end
    else
      clean_up_passwords resource
      render :json => {:success => false, message: errors_to_message_string( resource.errors )}
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:full_name, :email, :password, :password_confirmation) }
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
