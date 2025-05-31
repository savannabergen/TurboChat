class MessagesController < ApplicationController
  before_action :set_room

  def index
    messages = @room.messages.includes(:user)
    render json: messages, status: :ok
  end

  def create
    message = @room.messages.new(message_params)
    message.user = current_user
    if message.save
      render json: message, status: :created
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end

  def message_params
    params.require(:message).permit(:content)
  end
end