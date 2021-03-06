
User.destroy_all
Wiki.destroy_all

# Create Users
5.times do
  User.create!(
    
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

# Create admin user
unless User.find_by(email: 'admin@example.com')
  User.create!(
    #name: 'Admin User',
    email: 'admin@example.com',
    password: 'helloworld',
    #role: 'admin'
  )
end

 premium = User.create!(
    email:    'premium@example.com',
    password: 'helloworld',
    role:     'premium'
  )


unless User.find_by(email: 'member@example.com')
  User.create!(
    #name: 'Member User',
    email: 'member@example.com',
    password: 'helloworld'
  )
end
users = User.all

puts "#{User.count} users created"

# Create Wikis
10.times do
  Wiki.create!(
    user: users.sample,
    title:  Faker::Hacker.noun,
    body:   Faker::Hacker.say_something_smart
  )
end

wikis = Wiki.all

puts "#{Wiki.count} posts created"

puts "Seed finished"