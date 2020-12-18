require 'rails_helper'

RSpec.describe "Admin Shelters Show Page" do
    before :each do
        @dans = Shelter.create!(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
        @kathys = Shelter.create!(name: "Kathy's Kathouse", address: "1 Rodeo Drive", city: "Beverly Hills", state: "CA", zip: 90210)
        @stinkys = Shelter.create!(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)
        
        @buck = @dans.pets.create!(name: 'Buck',
            approximate_age: 2,
            description: "big and black, loves peanut butter, hates mailmen", 
            adoptable: true,
            sex: 0)
        @princess = @dans.pets.create!(name: 'Princess',
            approximate_age: 5,
            description: "130 pound fluffball", 
            adoptable: true,
            sex: 1)
        @kathys.pets.create!(name: 'Max',
            approximate_age: 1,
            description: "can howl like an old blues singer", 
            adoptable: true,
            sex: 0)
        @lil = @kathys.pets.create!(name: 'Lill',
            approximate_age: 1,
            description: "loves to eat furniture", 
            adoptable: true,
            sex: 1)
        @stinkys.pets.create!(name: 'Cruela',
            approximate_age: 9,
            description: "blind, deaf, and toothless - with a heart of gold", 
            adoptable: true,
            sex: 1)
        @chester = @stinkys.pets.create!(name: 'Chester',
            approximate_age: 7,
            description: "SQUIRREL!!!", 
            adoptable: true,
            sex: 0)

                    
        @adam = Applicant.create!(name: "Adam Cohen", address: "1c Lola Road", city: "Miami", state: "FL", zip: 33434)
        @georgia = Applicant.create!(name: "Georgia Arthur", address: "10 Pelican Drive", city: "Philadelphia", state: "PA", zip: 22243)
        @linzi = Applicant.create!(name: "Linzi Hurwitz", address: "333 N Federal Hwy", city: "Boca Raton", state: "FL", zip: 33432)

        @adam.applications.create!(description: "I like turtles")
        @georgia.applications.create!(description: "I don't like turtles")
        @linzi.applications.create!(description: "I don't like my furniture")

        Adoption.create!(pet: @buck, application: @adam.applications.first)
        Adoption.create!(pet: @princess, application: @georgia.applications.first)

    end

    describe "As a visitor, I visit admin/shelters/:id" do
        it "displays the shelter's name and full address and avg pet age" do
            visit "admin/shelters/#{@dans.id}"
            save_and_open_page
            expect(page).to have_content(@dans.name)
            expect(page).to have_content(@dans.address)
            expect(page).to have_content(@dans.state)
            expect(page).to have_content(@dans.zip)

            within("#statistics") do
                expect(page).to have_content(3.5)
                expect(page).to have_content(2)
                expect(page).to have_content(0)
            end
        
        end
    end
end