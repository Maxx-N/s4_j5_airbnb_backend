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

# Créer 100 logements
  100.times do |index|
    a = Accomodation.new
    a.id = index + 1
    a.available_beds = rand(1..8)
    a.price = rand(30..100)
    a.description = Faker::Lorem.paragraph_by_chars(number: 145)
    a.has_wifi = [true, false].sample
    a.welcome_message = "Bonjour! Passez un bon séjour dans notre magnifique logement !"
    a.city = City.all[rand(0..(City.all.length - 1))]
    a.administrator = User.all[rand(0..(User.all.length - 1))]
    a.save
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
    puts "     - #{a.available_beds} couchages à #{a.city.name} (#{a.city.zip_code}), pour #{a.price}€/nuit"
  end
  puts "\n"
  puts "Vous pouvez le(la) contacter au : #{my_user.phone_number}"

    
# Créer 50 réservations
  50.times do |index|
    r = Reservation.create(
      id: index + 1,
      start_date: Faker::Date.between(from: Date.today, to: 364.day.from_now),
      end_date: Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now),
      accomodation: Accomodation.all[rand(0..(Accomodation.all.length - 1))],
      guest: User.all[rand(0..(User.all.length - 1))]
    )
  end

# Afficher les réservations
  puts "\n"
  puts "Voici les #{Reservation.all.length} réservations existantes :"
  puts "\n"
  tp Reservation.all, :id, :start_date, :end_date, :accomodation_id, :guest_id