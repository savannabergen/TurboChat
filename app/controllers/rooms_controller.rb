class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :participants]

  def create
    room = Room.new(room_params)
    if room.save
      ActionCable.server.broadcast "rooms", {
        room: RoomSerializer.new(room).serializable_hash[:data]
      }
      render json: { status: { code: 201, message: 'Room created successfully.' }, data: RoomSerializer.new(room).serializable_hash[:data] }, status: :created
    else
      render json: { status: { code: 422, message: 'Room could not be created.' }, errors: room.errors }, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :is_private)
  end
end