# Supprimer les bases de données précédentes
  User.destroy_all
  City.destroy_all
  Accomodation.destroy_all
  Reservation.destroy_all


# Créer 10 users
  10.times do |index|
    u = User.new
    u.id = index + 1
    u.email = Faker::Internet.unique.email
    u.phone_number = "06#{Faker::PhoneNumber.unique.extension}#{Faker::PhoneNumber.extension}"
    u.description = "Bonjour, je m'appelle #{Faker::Name.name}, j'ai #{rand(18..60)} ans et je viens de #{Faker::Address.city}"
    u.save
  end

# Afficher les utilisateurs créés
  puts "\n"
  tp User.all, :id, :email, :phone_number

# Créer 10 villes
  10.times do |index|
    c = City.new
    c.id = index + 1
    c.name = Faker::Address.unique.city
    c.zip_code = "#{rand(0..9)}#{rand(1..5)}#{Faker::Number.unique.between(from: 10, to: 88)}0"
    c.save
  end

# Afficher les villes créées
  puts "\n"
  tp City.all, :id, :name, :zip_code

# Créer 10 logements
  10.times do |index|
    a = Accomodation.new
    a.id = index + 1
    a.available_beds = rand(1..8)
    a.price = rand(30..100)
    a.description = Faker::Lorem.paragraph_by_chars(number: 145)
    a.has_wifi = [true, false].sample
    a.welcome_message = "Bonjour! Passez un bon séjour dans notre magnifique logement !"
    a.city = City.all.find(rand(1..City.all.length))
    a.administrator = User.all.find(rand(1..User.all.length))
    a.save
  end

# Afficher les logements créés
    puts "\n"
    tp Accomodation.all, :id, :available_beds, :price, :has_wifi, :administrator_id, :city_id

# Prend un logement au hasard et affiche son nombre de places, sont prix, sa ville et l'email de son propriétaire
  a = Accomodation.all.sample
  puts "\n"
  puts "L'utilisateur ayant l'email \"#{a.administrator.email}\" propose #{a.available_beds} couchages à #{a.price} € / nuit dans la ville de #{a.city.name}"

    
    

  
