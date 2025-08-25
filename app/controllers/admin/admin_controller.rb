class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!
  # before_action :require_admin_role!
    
  private
    
  def require_admin_role!
    unless current_admin&.admin? || current_admin&.super_admin?
      render json: { error: 'Insufficient admin privileges' }, status: :forbidden
      return false
    end
  end
end
