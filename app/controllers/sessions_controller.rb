class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      payload = {
        user_id: user.id,
        exp: 24.hours.from_now.to_i, 
        jti: SecureRandom.uuid         
      }

      token = JWT.encode(
        payload, 
        Rails.application.credentials.secret_key_base, 
        'HS256'
      )

      safe_user_data = {
      id: user.id,
      email: user.email,
      username: user.username
    }
      
      render json: { 
        message: 'Login successful', 
        user: safe_user_data, 
        token: token 
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def destroy
    token = request.headers['Authorization']&.split(' ')&.last

    if token.nil?
      return render json: { error: 'Authorization token not provided' }, status: :unauthorized
    end

    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })
      payload = decoded_token.first
      
      JwtDenylist.create!(jti: payload['jti'], exp: Time.at(payload['exp']))
      
      render json: { message: 'Logged out successfully' }, status: :ok

    rescue JWT::DecodeError => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end
end
