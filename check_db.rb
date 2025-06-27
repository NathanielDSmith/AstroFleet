puts "Users:"
User.all.each do |u|
  puts "ID: #{u.id}, Email: #{u.email}"
end

puts "\nSpaceships:"
Spaceship.all.each do |s|
  puts "ID: #{s.id}, Name: #{s.name}, User ID: #{s.user_id}"
end

puts "\nCurrent user ID: #{User.first.id if User.any?}" 