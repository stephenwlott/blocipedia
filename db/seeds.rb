require 'faker'
 
# Create Users
5.times do
  role_num = rand(1..100)
  if role_num == 1
    role = "admin"
  elsif (role_num == 2) || (role_num == 3)
    role = "premium"
  else
    role = "standard"
  end
    
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10),
    role:     role
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
10.times do
  wiki = Wiki.create!(
    user_id: users.sample.id,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
  # set the created_at to a time within the past year
  wiki.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

puts "Seeding finished"
puts "users count = #{User.count}"
puts "wikis count = #{Wiki.count}"