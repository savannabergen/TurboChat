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
      Turbo::StreamsChannel.broadcast_append_to @room, target: "messages", partial: ApplicationController.render(partial: "messages/message", locals: { message: message }, formats: [:json])
      render json: message, status: :created
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
    # Ensure current user is a participant in the room
    unless @room.participants.include?(current_user)
      render json: { error: "You are not a participant in this room" }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Room not found" }, status: :not_found
  end

  def message_params
    params.require(:message).permit(:body)
  end
end