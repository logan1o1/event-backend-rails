class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all.includes(:user, :category) 

    if params[:query].present?
      search_term = "%#{params[:query]}%"
      @events = @events.joins(:category).where(
        "events.title ILIKE ? OR categories.name ILIKE ?",
        search_term,
        search_term
      )
    end

    render json: @events, include: {
      user: { only: [:id, :username] }, 
      category: { only: [:id, :name] }                    
    }, status: :ok
  end

  # GET /events/1 or /events/1.json
  def show
    render json: @event, include: [:user, :category]
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    unless @event.user == current_user
      return render json: { error: "Not authorized to update this event." }, status: :forbidden
    end

    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    unless @event.user == current_user
      return render json: { error: "Not authorized to delete this event." }, status: :forbidden
    end

    @event.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :date, :location, :poster_url, :category_id)
    end
end
