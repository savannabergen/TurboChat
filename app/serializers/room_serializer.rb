class RoomSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :is_private
end
