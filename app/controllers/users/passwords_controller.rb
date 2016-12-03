class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    respond_to do |format|
      if instructions_sent?(resource)
        format.json { render json: {success: true, redirect_path: root_path} }
      else
        format.json { render json: {success: false, message: errors_to_message_string(resource.errors)} }
      end
    end

  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        if resource.confirmed?
          sign_in(resource_name, resource)
          set_flash_message!(:success, flash_message)
        else
          return redirect_to root_path, success: t(:reset_password_email_not_confirmed)
        end
      else
        set_flash_message!(:warning, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      flash[:danger] = errors_to_message_string(resource.errors)
      respond_with resource
    end
  end

  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end

  private
  def instructions_sent?(resource)
    notice = if Devise.paranoid
               resource.errors.clear
               :send_paranoid_instructions
             elsif resource.errors.empty?
               :send_instructions
             end

    if notice
      set_flash_message! :success, notice
      true
    end
  end
end
