require 'faker'

# Create users
users = []
10.times do |i|
  user = User.create!(email: Faker::Internet.email, password: "password")
  users << user
end

# Create rooms
rooms = []
5.times do |i|
  room = Room.create!(name: Faker::Lorem.word)
  rooms << room
end

# Create messages
100.times do |i|
  user = users.sample
  room = rooms.sample
  message = Message.create!(body: Faker::Lorem.sentence, user: user, room: room)
end
