class RoomsController < ApplicationController
  before_action :set_room, only: [:show]

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

  private

  def set_room
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end

  def room_params
    params.require(:room).permit(:name, :is_private)
  end
end
