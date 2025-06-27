# Create some test spaceships for other users
other_users = User.where.not(id: 59).limit(3)

if other_users.any?
  puts "Creating test spaceships for other users..."
  
  test_spaceships = [
    { name: "Galactic Cruiser", price: 2500, max_speed: 850, features: "Luxury amenities, advanced navigation", size: "large", description: "A luxurious cruiser for the discerning space traveler" },
    { name: "Mining Vessel", price: 1800, max_speed: 650, features: "Mining equipment, cargo hold", size: "medium", description: "Perfect for asteroid mining operations" },
    { name: "Scout Ship", price: 1200, max_speed: 1200, features: "Stealth systems, long range sensors", size: "small", description: "Fast and agile reconnaissance vessel" },
    { name: "Cargo Hauler", price: 3000, max_speed: 500, features: "Massive cargo capacity, durable hull", size: "mega big", description: "Built for heavy cargo transport across the galaxy" },
    { name: "Explorer Class", price: 2200, max_speed: 900, features: "Scientific equipment, research labs", size: "large", description: "Designed for deep space exploration and research" }
  ]
  
  other_users.each_with_index do |user, index|
    spaceship_data = test_spaceships[index % test_spaceships.length]
    spaceship = Spaceship.new(spaceship_data)
    spaceship.user = user
    
    if spaceship.save
      puts "Created #{spaceship.name} for user #{user.email}"
    else
      puts "Failed to create spaceship for user #{user.email}: #{spaceship.errors.full_messages}"
    end
  end
else
  puts "No other users found to create spaceships for."
end

puts "\nCurrent spaceship count by user:"
User.all.each do |user|
  count = user.spaceships.count
  puts "#{user.email}: #{count} spaceships"
end 