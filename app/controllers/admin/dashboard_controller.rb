class Admin::DashboardController < Admin::AdminController
  def index
    render json: {
        total_users: User.count,
        total_events: Event.count,
        recent_events: Event.order(created_at: :desc).limit(5)
      }
  end
end
