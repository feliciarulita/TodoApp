# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin"
  user.password = "12345"
  user.password_confirmation = "12345"
  user.manager = true
end

tags = [ "Urgent", "Work", "School", "Personal" ]

tags.each do |tag_name|
  # Tag.find_or_create_by! checks for a tag with the matching name.
  Tag.find_or_create_by!(name: tag_name)
end
