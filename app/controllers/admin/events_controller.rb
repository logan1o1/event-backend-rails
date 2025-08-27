class Admin::EventsController < Admin::AdminController
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

    render json: { events: @events }, include: {
      user: { only: [:id, :username] }, 
      category: { only: [:id, :name] }                    
    }, status: :ok
  end

  def show
    @event = Event.find(params[:id])
    render json: { event: @event }, status: :ok
  end

  def update
    @event = Event.find(params[:id])  
    if @event.update(event_params)
      render json: { message: "Event updated successfully", event: @event }
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])  
    @event.destroy
    render json: { message: "Event deleted successfully" }
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
