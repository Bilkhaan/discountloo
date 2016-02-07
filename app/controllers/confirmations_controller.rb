class ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :verify_authenticity_token, only: [:show]

  def show
    user = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    if user && user.update(confirmed_at: Time.now)
      user.ensure_authentication_token
      redirect_to users_success_path
    else
      redirect_to users_error_path
    end
  end
end
