require 'rails_helper'

RSpec.describe "Admin Shelters Index" do
    before :each do
        @dans = Shelter.create!(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
        @kathy = Shelter.create!(name: "Kathy's Kathouse", address: "1 Rio Drive", city: "Beverly Hills", state: "CA", zip: 90210)
        @stinky = Shelter.create!(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)

        
    end
    describe "As a visitor, I visit /admin/shelters" do
        it "Displays all Shelters in reversed alphabetical order by name" do
            visit '/admin/shelters'

            expect(page.all("#shelters")[2]).to have_content(@dans.name)
            expect(page.all("#shelters")[2]).to have_content(@dans.address)
            expect(page.all("#shelters")[2]).to have_content(@dans.state)
            expect(page.all("#shelters")[2]).to have_content(@dans.zip)

            expect(page.all("#shelters")[1]).to have_content(@kathy.name)
            expect(page.all("#shelters")[1]).to have_content(@kathy.address)
            expect(page.all("#shelters")[1]).to have_content(@kathy.state)
            expect(page.all("#shelters")[1]).to have_content(@kathy.zip)

            expect(page.all("#shelters")[0]).to have_content(@stinky.name)
            expect(page.all("#shelters")[0]).to have_content(@stinky.address)
            expect(page.all("#shelters")[0]).to have_content(@stinky.state)
            expect(page.all("#shelters")[0]).to have_content(@stinky.zip)
        end

        it "displays a section for shelters with pending applications" do
            visit '/admin/shelters'
            save_and_open_page

            expect(page.all("#pending").to have_content(@dans.name)

        end
    end
end