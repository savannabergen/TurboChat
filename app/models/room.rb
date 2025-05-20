class Room < ApplicationRecord
  validates_uniqueness_of :name

  scope :public_rooms, -> { where(is_private: false) }

  after_create_commit :notify_clients

  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy

  def notify_clients
    $redis.publish("rooms", { room: self }.to_json) unless is_private
  end

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id)
    end
    single_room
  end

  def participant?(room, user)
    # This method seems to be incorrectly defined, it should probably be an instance method without the room argument
    participants.where(user: user).exists?
  end
end
