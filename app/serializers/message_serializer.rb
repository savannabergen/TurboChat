class MessageSerializer
  include JSONAPI::Serializer
  attributes :id, :body, :user_id, :room_id
end
