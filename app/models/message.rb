class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_create :confirm_participant
  after_create_commit :notify_clients

  def confirm_participant
    return unless room.is_private
    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end

  def notify_clients
    $redis.publish("room:#{room.id}", { message: self }.to_json)
  end
end
