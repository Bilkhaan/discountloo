class SessionsController < Devise::SessionsController
  before_action :set_user, only: [:create]
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    if @user.present?
      render json: {state: {code: 0}, data: @user }
    else
      render json: {state: {code: 1, messages: 'Email or password is incorrecr'} }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by_email(params[:user][:email])
    if @user.present?
      @user = nil unless @user.valid_password?(params[:user][:password])
    end
  end
end
