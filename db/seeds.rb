# Supprimer les bases de données précédentes
  User.destroy_all
  City.destroy_all
  Accomodation.destroy_all
  Reservation.destroy_all

# Créer 20 users
  20.times do |index|
    u = User.create(
      id: index + 1,
      email: Faker::Internet.unique.email,
      phone_number: "06#{Faker::PhoneNumber.unique.extension}#{Faker::PhoneNumber.extension}",
      description: "Bonjour, je m'appelle #{Faker::Name.name}, j'ai #{rand(18..60)} ans et je viens de #{Faker::Address.city}"
    )
  end

# Afficher les utilisateurs(trices) créé(e)s
  puts "\n"
  puts "Voici la liste des #{User.all.length} utilisateurs :"
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
  puts "Voici la liste des #{City.all.length} villes disponibles :"
  puts "\n"
  tp City.all, :id, :name, :zip_code

# Créer 50 logements
  50.times do |index|
    a = Accomodation.create(
      id: index + 1,
      available_beds: rand(1..8),
      price: rand(30..100),
      description: Faker::Lorem.paragraph_by_chars(number: 145),
      has_wifi: [true, false].sample,
      welcome_message: "Bonjour! Passez un bon séjour dans notre magnifique logement !",
      city: City.all[rand(0..(City.all.length - 1))],
      administrator: User.all[rand(0..(User.all.length - 1))]
    )
  
  end

# Afficher les logements créés
    puts "\n"
    puts "Voici la liste des #{Accomodation.all.length} logements disponibles :"
    puts "\n"
    tp Accomodation.all, :id, :available_beds, :price, :has_wifi, :administrator_id, :city_id


# Prendre un utilisateur au hasard, affiche son mail, ses logements et son numéro de téléphone
  puts "\n"
  my_user = User.all.sample
  puts "Voici la liste des logements proposés par \"#{my_user.email}\" :"
  puts "\n"
  my_user_properties = my_user.owned_accomodations
  my_user_properties.each do |a|
    puts "     - #{a.available_beds} couchage(s) à #{a.city.name} (#{a.city.zip_code}), pour #{a.price}€/nuit"
  end
  puts "\n"
  puts "Vous pouvez le(la) contacter au : #{my_user.phone_number}"

# Créer 10 réservations
  10.times do |index|
    r = Reservation.new
    r.id = index + 1
    r.start_date = Faker::Date.between(from: Date.today, to: 364.day.from_now)
    r.end_date = Faker::Date.between(from: (r.start_date + 1.day), to: 365.day.from_now)
    r.accomodation = Accomodation.all[rand(0..(Accomodation.all.length - 1))]
    r.guest = User.all[rand(0..(User.all.length - 1))]
    while r.guest == r.accomodation.administrator
      r.guest = User.all[rand(0..(User.all.length - 1))]
    end
    until r.is_not_overlaping
      r.start_date = Faker::Date.between(from: Date.today, to: 364.day.from_now)
      r.end_date = Faker::Date.between(from: (r.start_date + 1.day), to: 365.day.from_now)
    end
    r.save
  end

# Afficher les réservations
  puts "\n"
  puts "Voici les #{Reservation.all.length} réservations existantes :"
  puts "\n"
  tp Reservation.all, :id, :start_date, :end_date, :accomodation_id, :guest_id
