# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'
require 'open-uri'
require 'faker'

csv_file_path = Rails.root.join('db', 'MOCK_DATA.csv')


CSV.foreach(csv_file_path, headers: true) do |row|
  next if row['email'].blank? || row['password'].blank?

    user = User.create!(
    email: row['email'],
    password: row['password'],
    password_confirmation: row['password']
    )

    avatar_url = row['avatar']
    avatar_io = URI.open(avatar_url)
    user.avatar.attach(io: avatar_io, filename: avatar_url.split('/').last)
    end

    admin_user = User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
    )

    admin_avatar_url = Faker::Avatar.image
    admin_avatar_io = URI.open(admin_avatar_url)
    admin_user.avatar.attach(io: admin_avatar_io, filename: admin_avatar_url.split('/').last)

    normal_user = User.create!(
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password'
    )

    normal_avatar_url = Faker::Avatar.image
    normal_avatar_io = URI.open(normal_avatar_url)
    normal_user.avatar.attach(io: normal_avatar_io, filename: normal_avatar_url.split('/').last)

    20.times do
    room = Room.find_or_create_by!(name: Faker::Hacker.adjective)
    end

    User.all.each do |user|
    Room.all.sample(3).each do |room|
    participant = Participant.find_or_create_by!(user: user, room: room)
    50.times do
    Message.create!(
    body: Faker::Lorem.paragraph(sentence_count: 2),
    user: user,
    room: room
    )
    end
  end
end
