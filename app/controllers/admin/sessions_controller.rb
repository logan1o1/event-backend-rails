# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!

  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with(resource)
  end

  def destroy
    sign_out(current_admin)
    respond_to_on_destroy
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Admin login successful.' },
      data: { id: resource.id, email: resource.email } 
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: "Admin logged out successfully."
    }, status: :ok
  end

end
