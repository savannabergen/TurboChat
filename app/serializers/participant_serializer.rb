class ParticipantSerializer
  include JSONAPI::Serializer
  attributes :id
  belongs_to :user, serializer: UserSerializer
end
