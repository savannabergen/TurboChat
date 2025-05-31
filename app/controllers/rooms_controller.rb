class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :participants]

  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end

  def show
    render json: @room, status: :ok
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { errors: room.errors }, status: :unprocessable_entity
    end
  end

  def participants
    participants = @room.participants.includes(:user)
    Rails.logger.debug "Participants: #{participants.inspect}"
    render json: participants.as_json(include: { user: { only: [:id, :email] } }), status: :ok
  end

  def room_params
    params.require(:room).permit(:name, :is_private)
  end

  private

  def set_room
    @room = Room.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end
end