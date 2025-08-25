# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      render json: { 
        message: 'Login successful', 
        user: user, 
        token: user.generate_jwt 
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def destroy
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
