require 'rails_helper'

RSpec.describe "Admin Shelters Show Page" do
    before :each do
        @dans = Shelter.create!(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
        @kathy = Shelter.create!(name: "Kathy's Kathouse", address: "1 Rio Drive", city: "Beverly Hills", state: "CA", zip: 90210)
        @stinky = Shelter.create!(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)
    end

    describe "As a visitor, I visit admin/shelters/:id" do
        it "displays the shelter's name and full address" do
            visit "admin/shelters/#{@dans.id}"

            expect(page).to have_content(@dans.name)
            expect(page).to have_content(@dans.address)
            expect(page).to have_content(@dans.state)
            expect(page).to have_content(@dans.zip)
        
        end
    end
end