require 'rails_helper'

RSpec.describe do "Admin Shelters Index" do
    before :each do
        dans = Shelter.new(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
        kathy = Shelter.new(name: "Kathy's Kathouse", address: "1 Rio Drive", city: "Beverly Hills", state: "CA", zip: 90210)
        stinky = Shelter.new(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)
    end
    describe "As a visitro, I visit /admin/shelters" do
        it "Displays all Shelters in reversed alphabetical order by name" do
            visit '/admin/shelters'

            expect(page.all("#shelters")[2]).to have_content(@dan.name)
            expect(page.all("#shelters")[1]).to have_content(@kathy.name)
            expect(page.all("#shelters")[0]).to have_content(@stinky.name)

            expect(page.all("#shelters")[2]).to have_content(@dan.address)
            expect(page.all("#shelters")[1]).to have_content(@kathy.address)
            expect(page.all("#shelters")[0]).to have_content(@stinky.address)
            
            expect(page.all("#shelters")[0]).to have_content(@dan.state)
            expect(page.all("#shelters")[0]).to have_content(@kathy.state)
            expect(page.all("#shelters")[0]).to have_content(@stinky.state)

            expect(page.all("#shelters")[2]).to have_content(@dan.zip)
            expect(page.all("#shelters")[1]).to have_content(@kathy.zip)
            expect(page.all("#shelters")[0]).to have_content(@stinky.zip)

        
        end
    end