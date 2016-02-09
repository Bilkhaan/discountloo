class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      render json: {state: {code: 0}, data: 'Password reset email has been sent.' }
    else
      render json: {state: {code: 1, messages: 'Unable to send the password reset email.'} }
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource.active_for_authentication?
        redirect_to users_password_success_path
      else
        redirect_to users_password_error_path
      end
    else
      set_minimum_password_length
      redirect_to users_password_error_path
    end
  end
end
