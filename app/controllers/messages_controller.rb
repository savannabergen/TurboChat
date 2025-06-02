class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def index
    messages = @room.messages.includes(:user)
    render json: {
      status: { code: 200, message: 'Messages retrieved successfully.' },
      data: MessageSerializer.new(messages).serializable_hash[:data]
    }, status: :ok
  end

  def create
    message = @room.messages.new(message_params)
    message.user = current_user
    if message.save
      Turbo::StreamsChannel.broadcast_append_to @room, target: "messages", partial: ApplicationController.render(partial: "messages/message", locals: { message: message }, formats: [:json])
      render json: {
        status: { code: 201, message: 'Message created successfully.' },
        data: MessageSerializer.new(message).serializable_hash[:data]
      }, status: :created
    else
      render json: {
        status: { code: 422, message: 'Message could not be created.' },
        errors: message.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
    rescue ActiveRecord::RecordNotFound
    render json: { status: { code: 404, message: 'Room not found.' } }, status: :not_found
  end

  def message_params
    params.require(:message).permit(:body)
  end
end