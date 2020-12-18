# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Adoption.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Applicant.destroy_all

dans = Shelter.create!(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
kathys = Shelter.create!(name: "Kathy's Kathouse", address: "1 Rodeo Drive", city: "Beverly Hills", state: "CA", zip: 90210)
stinkys = Shelter.create!(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)

dans.pets.create!(name: 'Buck',
    approximate_age: 2,
    description: "big and black, loves peanut butter, hates mailmen", 
    adoptable: true,
    sex: 1)
dans.pets.create!(name: 'Princess',
    approximate_age: 5,
    description: "130 pound fluffball", 
    adoptable: true,
    sex: 0)
kathys.pets.create!(name: 'Max',
    approximate_age: 1,
    description: "can howl like an old blues singer", 
    adoptable: true,
    sex: 1)
kathys.pets.create!(name: 'Lill',
    approximate_age: 1,
    description: "loves to eat furniture", 
    adoptable: true,
    sex: 0)
stinkys.pets.create!(name: 'Cruela',
    approximate_age: 9,
    description: "blind, deaf, and toothless - with a heart of gold", 
    adoptable: true,
    sex: 0)
stinkys.pets.create!(name: 'Chester',
    approximate_age: 7,
    description: "SQUIRREL!!!", 
    adoptable: true,
    sex: 1)

# adam = Applicant.create!(name: "Adam Cohen", address: "1c Lola Road", city: "Miami", state: "FL", zip: 33434)
# georgia = Applicant.create!(name: "Georgia Arthur", address: "10 Pelican Drive", city: "Philadelphia", state: "PA", zip: 22243)
# linzi = Applicant.create!(name: "Linzi Hurwitz", address: "333 N Federal Hwy", city: "Boca Raton", state: "FL", zip: 33432)