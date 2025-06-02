class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :participants]

  def index
    rooms = Room.all
    render json: {
      status: { code: 200, message: 'Rooms retrieved successfully.' },
      data: RoomSerializer.new(rooms).serializable_hash[:data]
    }, status: :ok
  end

  def show
    render json: {
      status: { code: 200, message: 'Room retrieved successfully.' },
      data: RoomSerializer.new(@room).serializable_hash[:data]
    }, status: :ok
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: {
        status: { code: 201, message: 'Room created successfully.' },
        data: RoomSerializer.new(room).serializable_hash[:data]
      }, status: :created
    else
      render json: {
        status: { code: 422, message: 'Room could not be created.' },
        errors: room.errors
      }, status: :unprocessable_entity
    end
  end

  def participants
    participants = @room.participants.includes(:user)
    render json: {
      status: { code: 200, message: 'Participants retrieved successfully.' },
      data: ParticipantSerializer.new(participants).serializable_hash[:data]
    }, status: :ok
  end

  private

  def set_room
    @room = Room.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { status: { code: 404, message: 'Room not found.' } }, status: :not_found
  end

  def room_params
    params.require(:room).permit(:name, :is_private)
  end
end