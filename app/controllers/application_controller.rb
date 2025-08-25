class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last

    if token.nil?
      return render json: { error: 'Unauthorized: No token provided' }, status: :unauthorized
    end

    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })

      payload = decoded.first

      if JwtDenylist.exists?(jti: payload['jti'])
        return render json: { error: 'Unauthorized: Token has been revoked' }, status: :unauthorized
      end

      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      render json: { error: "Unauthorized: #{e.message}" }, status: :unauthorized
      return false
    end
  end

  def current_user
    @current_user
  end
end
