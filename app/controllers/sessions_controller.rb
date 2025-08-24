class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')
      render json: { message: 'Login successful', token: token, user: user }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    # session.delete(:user_id)
    render json: { message: "Logout successful" }, status: :ok
  end
end
