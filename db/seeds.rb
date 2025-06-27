require "open-uri"

puts "🧹 Clearing database..."
Booking.destroy_all
Spaceship.destroy_all
User.destroy_all

puts "👤 Creating user..."
owner = User.create!(
  first_name: "Buzz",
  last_name: "Lightyear",
  email: "buzz@starfleet.com",
  password: "password123"
)

10.times do |number|
  User.create!(
    first_name: "Space",
    last_name: "Traveler #{number}",
    email: "spacetraveler#{number}@starfleet.com",
    password: "password123"
  )
end

puts "🚀 Creating spaceships..."

spaceships = [
  {
    name: "Enterprise NCC-1701-D",
    price: 1_200_000,
    max_speed: 300_000,
    size: "large",
    features: "Holodeck, Warp drive, Saucer separation, Replicators, Photon torpedoes, Android crew member, Ten Forward lounge",
    photo: "https://startrekfleetcommand.com/wp-content/uploads/2021/05/TNG_LoadingScreen03.png",
    description: "Flagship of the United Federation of Planets, equipped with advanced tech and diplomacy skills. Perfect for peaceful exploration and first contact missions.",
    rating: 5
  },
  {
    name: "Death Star",
    price: 2_147_483_647,
    max_speed: 24_000,
    size: "mega",
    features: "Planet-destroying superlaser, Thermal exhaust vent, Droid command center, Tractor beam array, Imperial stormtroopers",
    photo: "https://www.stickyminds.com/sites/default/files/article/2014/death-star.jpg",
    description: "A moon-sized imperial battle station capable of annihilating entire planets. Not recommended for family vacations.",
    rating: 4
  },
  {
    name: "Event Horizon",
    price: 1_200_000_000,
    max_speed: 500_000,
    size: "medium",
    features: "Gravity drive, Hull breach mode, Distress beacon, Interdimensional travel, Crew-induced madness, Hell dimension access",
    photo: "https://www.giantfreakinrobot.com/wp-content/uploads/2020/02/event-horizon-900x522.jpg",
    description: "A terrifying experimental ship that folds space... and minds. Only for the bravest (or most foolish) travelers.",
    rating: 3
  },
  {
    name: "Millennium Falcon",
    price: 42_000_000,
    max_speed: 153_300,
    size: "medium",
    features: "Hyperdrive, Kessel Run capability, Hidden compartments, Smuggling holds, Wookiee co-pilot, Dejarik table",
    photo: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800",
    description: "The fastest hunk of junk in the galaxy. Made the Kessel Run in less than 12 parsecs. Perfect for smuggling and adventure.",
    rating: 5
  },
  {
    name: "Eagle 5 (Space Winnebago)",
    price: 28_000,
    max_speed: 150_000,
    size: "small",
    features: "Wings, Radar dish, Lone Starr's piloting, Barf-proof upholstery, Coffee machine, Mega-maid escape capability",
    photo: "https://wallpapers.com/images/hd/spaceballs-dg4gamkof51ci5c6.jpg",
    description: "A Winnebago in space. Surprisingly durable, endlessly meme-worthy. Great for budget-conscious space travelers.",
    rating: 2
  },
  {
    name: "Nebula Interceptor",
    price: 23_000,
    max_speed: 180_000,
    size: "small",
    features: "Twin ion engines, Solar panel wings, Targeting computer, Advanced communications, Life support system",
    photo: "https://i.pinimg.com/736x/02/20/b3/0220b306531f5c22b4bc6ca1a3502261.jpg",
    description: "Fast and agile fighter craft designed for deep space patrol. Excellent for quick reconnaissance missions and defensive operations.",
    rating: 3
  },
  {
    name: "Stellar Explorer",
    price: 25_000,
    max_speed: 350_000,
    size: "small",
    features: "Four laser cannons, Proton torpedoes, Astromech droid socket, S-foil wings, Hyperdrive, Targeting computer",
    photo: "https://img.freepik.com/free-photo/view-futuristic-looking-spacecraft_23-2150675563.jpg?semt=ais_hybrid&w=740",
    description: "A versatile exploration vessel with excellent firepower and maneuverability. Perfect for charting unknown territories.",
    rating: 4
  },
  {
    name: "Mandalorian Hunter",
    price: 40_000,
    max_speed: 250_000,
    size: "medium",
    features: "Carbonite freezing chamber, Hidden weapons cache, Bounty hunting equipment, Living quarters, Cargo hold",
    photo: "https://cdn.mos.cms.futurecdn.net/eJCVbwUPfV9Mx7sH7bdPRj.jpg",
    description: "Rugged bounty hunter's vessel designed for the toughest jobs. Equipped for any mission, legal or otherwise.",
    rating: 5
  },
  {
    name: "Imperial Destroyer",
    price: 30_000_000,
    max_speed: 200_000,
    size: "large",
    features: "Turbolaser batteries, Fighter complement, Tractor beam, Stormtrooper barracks, Command bridge, Medical bay",
    photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBHfe3SPdBD2xOEdMfIueRjB8ZuPwGqiDujw&s",
    description: "Massive capital ship with overwhelming firepower and troop capacity. Intimidating presence in any star system.",
    rating: 4
  },
  {
    name: "Cornerian Defender",
    price: 38_000,
    max_speed: 250_000,
    size: "small",
    features: "Twin laser cannons, Smart bombs, G-diffuser system, All-range mode, Barrel roll capability, Team communication",
    photo: "https://bookbub-res.cloudinary.com/image/upload/w_1200,h_628,c_fill,g_auto,f_auto,q_auto/v1689780563/blog/the-most-fascinating-spaceships-in-science-fiction-share.jpg",
    description: "Advanced fighter craft with exceptional aerial combat capabilities. Perfect for precision missions and tactical operations.",
    rating: 4
  },
  {
    name: "Deep Space Ranger",
    price: 38_000_000,
    max_speed: 280_000,
    size: "medium",
    features: "Cryosleep pods, AI companion, Endurance docking, Advanced robotics, Mission planning systems, Time dilation protection",
    photo: "https://images.saymedia-content.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTk2ODg5NjQ5OTk2NzAyOTc5/largest-spaceships-science-fiction.jpg",
    description: "NASA's premier deep space exploration vessel. Designed for extended missions beyond the solar system.",
    rating: 5
  },
  {
    name: "Xenomorph Hive",
    price: 20_000_000,
    max_speed: 24_000,
    size: "large",
    features: "Abduction beams, Cloning chambers, Genetic experimentation labs, Hive mind control, Advanced weaponry",
    photo: "https://cdna.artstation.com/p/assets/images/images/033/453/542/large/vitaliy-ostaschenko-renderendevour6.jpg?1609671428",
    description: "Mysterious alien vessel with unknown capabilities. Approach with extreme caution. Not for the faint-hearted.",
    rating: 4
  },
  {
    name: "Firefly Transport",
    price: 85_000,
    max_speed: 180_000,
    size: "medium",
    features: "Cargo bay, Shuttle dock, Medical bay, Kitchen, Bunks for crew, Hidden compartments, Atmospheric capability",
    photo: "https://images.unsplash.com/photo-1446776877081-d282a0f896e2?w=800",
    description: "A reliable transport ship with a good heart. Perfect for smuggling and honest work across the galaxy.",
    rating: 4
  },
  {
    name: "Colonial Battlestar",
    price: 500_000_000,
    max_speed: 150_000,
    size: "large",
    features: "Viper launch tubes, Nuclear warheads, FTL drive, CIC command center, Medical facilities, Flight deck",
    photo: "https://images.unsplash.com/photo-1446776858070-70c3d5ed6758?w=800",
    description: "Military vessel designed to protect humanity. So say we all!",
    rating: 5
  },
  {
    name: "Jupiter Mission Vessel",
    price: 75_000_000,
    max_speed: 200_000,
    size: "large",
    features: "Advanced AI computer, Centrifuge, Pod bay, Monolith detection, Jupiter mission capability, Cryogenic storage",
    photo: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800",
    description: "NASA's Jupiter mission vessel. Perfect for deep space exploration and scientific discovery.",
    rating: 4
  }
]

spaceships.each do |attrs|
  puts "Creating #{attrs[:name]}..."
  
  # Map spaceship names to appropriate images
  image_data = case attrs[:name]
  when "Enterprise NCC-1701-D"
    { type: :local, filename: "Enterprise.jpg" }
  when "Death Star"
    { type: :local, filename: "Death Star.jpg" }
  when "Event Horizon"
    { type: :local, filename: "Event Horizon.jpg" }
  when "Millennium Falcon"
    { type: :local, filename: "Millenium Falcon.jpg" }
  when "Eagle 5 (Space Winnebago)"
    { type: :local, filename: "Spaceballs Eagle 5.webp" }
  when "Nebula Interceptor"
    { type: :url, url: "https://i.pinimg.com/736x/02/20/b3/0220b306531f5c22b4bc6ca1a3502261.jpg" }
  when "Stellar Explorer"
    { type: :url, url: "https://img.freepik.com/free-photo/view-futuristic-looking-spacecraft_23-2150675563.jpg?semt=ais_hybrid&w=740" }
  when "Mandalorian Hunter"
    { type: :url, url: "https://cdn.mos.cms.futurecdn.net/eJCVbwUPfV9Mx7sH7bdPRj.jpg" }
  when "Imperial Destroyer"
    { type: :url, url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBHfe3SPdBD2xOEdMfIueRjB8ZuPwGqiDujw&s" }
  when "Cornerian Defender"
    { type: :url, url: "https://bookbub-res.cloudinary.com/image/upload/w_1200,h_628,c_fill,g_auto,f_auto,q_auto/v1689780563/blog/the-most-fascinating-spaceships-in-science-fiction-share.jpg" }
  when "Deep Space Ranger"
    { type: :url, url: "https://images.saymedia-content.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTk2ODg5NjQ5OTk2NzAyOTc5/largest-spaceships-science-fiction.jpg" }
  when "Xenomorph Hive"
    { type: :url, url: "https://cdna.artstation.com/p/assets/images/images/033/453/542/large/vitaliy-ostaschenko-renderendevour6.jpg?1609671428" }
  when "Firefly Transport"
    { type: :url, url: "https://images.unsplash.com/photo-1446776877081-d282a0f896e2?w=800" }
  when "Colonial Battlestar"
    { type: :url, url: "https://images.unsplash.com/photo-1446776858070-70c3d5ed6758?w=800" }
  when "Jupiter Mission Vessel"
    { type: :url, url: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800" }
  else
    { type: :local, filename: "Enterprise.jpg" }  # Default fallback
  end

  spaceship = Spaceship.new(
    name: attrs[:name],
    price: attrs[:price],
    max_speed: attrs[:max_speed],
    size: attrs[:size],
    features: attrs[:features],
    description: attrs[:description],
    rating: attrs[:rating],
    user: owner
  )

  # Attach the appropriate image
  begin
    if image_data[:type] == :local
      image_path = Rails.root.join("app", "assets", "images", image_data[:filename])
      if File.exist?(image_path)
        content_type = case image_data[:filename].split('.').last.downcase
        when 'jpg', 'jpeg'
          'image/jpeg'
        when 'png'
          'image/png'
        when 'webp'
          'image/webp'
        else
          'image/jpeg'
        end
        
        spaceship.photo.attach(
          io: File.open(image_path),
          filename: image_data[:filename],
          content_type: content_type
        )
        puts "📸 Attached local image: #{image_data[:filename]}"
      else
        puts "⚠️  Local image not found: #{image_data[:filename]}"
      end
    elsif image_data[:type] == :url
      # Download image from URL and attach it
      require 'open-uri'
      begin
        file = URI.parse(image_data[:url]).open
        filename = "#{attrs[:name].gsub(/[^a-zA-Z0-9]/, '_')}.jpg"
        
        spaceship.photo.attach(
          io: file,
          filename: filename,
          content_type: 'image/jpeg'
        )
        puts "📸 Downloaded and attached: #{image_data[:url]}"
      rescue => e
        puts "⚠️  Failed to download image from #{image_data[:url]}: #{e.message}"
        # Fallback to a local image
        fallback_path = Rails.root.join("app", "assets", "images", "Enterprise.jpg")
        if File.exist?(fallback_path)
          spaceship.photo.attach(
            io: File.open(fallback_path),
            filename: "Enterprise.jpg",
            content_type: 'image/jpeg'
          )
          puts "📸 Used fallback image: Enterprise.jpg"
        end
      end
    end
  rescue => e
    puts "⚠️  Error attaching image: #{e.message}"
  end

  spaceship.save
  puts "✅ Created #{spaceship.name}"
end

puts "🌌 Finished seeding #{Spaceship.count} spaceships for Commander #{owner.first_name} #{owner.last_name}"


# Pick one booker to keep things simple
booker = User.create!(
  first_name: "Han",
  last_name: "Solo",
  email: "han@falcon.space",
  password: "password123"
)

bookings = [
  {
    spaceship: Spaceship.all.sample,
    user: booker,
    start_date: Date.today + 1,
    end_date: Date.today + 5,
    total_price: 200_000
  },
  {
    spaceship: Spaceship.all.sample,
    user: booker,
    start_date: Date.today + 10,
    end_date: Date.today + 12,
    total_price: 1_000_000
  },
 {
    spaceship: Spaceship.all.sample,
    user: booker,
    start_date: Date.today + 3,
    end_date: Date.today + 7,
    total_price: 300_000
  },
    {
    spaceship: Spaceship.all.sample,
    user: booker,
    start_date: Date.today - 20,
    end_date: Date.today - 15,
    total_price: 28_000
  },

      {
    spaceship: Spaceship.all.sample,
    user: booker,
    start_date: Date.today - 98,
    end_date: Date.today - 94,
    total_price: 1_200_000_000
  }
]

bookings.each do |attrs|
  Booking.create!(attrs)
end

puts "📅 Seeded #{Booking.count} spaceship bookings for #{booker.first_name} #{booker.last_name}"
