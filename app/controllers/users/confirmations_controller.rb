class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create

    user = User.find_by_email(params[:user][:email])
    if user.present? && user.confirmed?
      redirect_to root_path, success: 'Email was already confirmed, please try signing in'
    else
      super
      if resource.errors.empty?
        flash[:success] = "We just sent an email to #{resource.email} with instructions on how to confirm that it belongs to you"
      end
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:success, :confirmed)
      sign_in(resource)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    if signed_in?(resource_name)
      new_course_path
    else
      root_path
    end
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      new_course_path
    else
      root_path
    end
  end
end
