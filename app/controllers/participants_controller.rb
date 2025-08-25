class ParticipantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_event, only: [:index, :create]
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /participants or /participants.json
  def index
    @participants = @event.participants.includes(:user)
    render json: @participants, include: :user
  end

  # GET /participants/1 or /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants or /participants.json
  def create
    if @event.participants.exists?(user_id: current_user.id)
      return render json: { error: 'You are already registered for this event.' }, status: :unprocessable_entity
    end

    @participant = @event.participants.new(user: current_user)

    if @participant.save
      render json: @participant, status: :created
    else
      render json: { errors: @participant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    unless @participant.user == current_user
      return render json: { error: 'Not authorized.' }, status: :forbidden
    end

    @participant.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_participant
      @participant = Participant.find(params[:id])
    end
end
