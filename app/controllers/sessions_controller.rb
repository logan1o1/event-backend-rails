class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      token = JWT.encode(
        { user_id: user.id }, 
        Rails.application.credentials.secret_key_base, 
        'HS256'
      )
      
      render json: { 
        message: 'Login successful', 
        user: user, 
        token: token 
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def destroy
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
