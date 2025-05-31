class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :notify_clients

  def notify_clients
    $redis.publish("room:#{room.id}", { message: self }.to_json)
  end

  def confirm_participant
  true
  end
end
