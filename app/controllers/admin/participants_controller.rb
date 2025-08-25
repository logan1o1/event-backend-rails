class Admin::ParticipantsController < Admin::AdminController
  before_action :set_event, only: [:index]

  def index
    @participants = @event.participants.includes(:user)
    render json: @participants, include: :user
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
