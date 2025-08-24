class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /participants or /participants.json
  def index
    @participants = Participant.all
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
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: "Participant was successfully created." }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: "Participant was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy!

    respond_to do |format|
      format.html { redirect_to participants_path, notice: "Participant was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.expect(participant: [ :event_id, :user_id ])
    end
end
