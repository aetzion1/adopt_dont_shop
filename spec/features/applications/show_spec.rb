require 'rails_helper'

RSpec.describe "the Application show page" do
    before :each do
        @shelter1 = FactoryBot.create(:shelter)
        @pet1 = FactoryBot.create(:pet, shelter: @shelter1)
        @pet2 = FactoryBot.create(:pet, shelter: @shelter1)
        @applicant1 = FactoryBot.create(:applicant)
        @application1 = FactoryBot.create(:application, applicant: @applicant1)

      end
    describe "As a visitor, when I visit /applications/:id" do
      it "should display Application info" do
          visit "/applications/#{@applicant1.id}"

          expect(page).to have_content(@applicant1.name)
          expect(page).to have_content(@applicant1.address)
          expect(page).to have_content(@applicant1.city)
          expect(page).to have_content(@applicant1.state)
          expect(page).to have_content(@applicant1.zip)
          expect(page).to have_content(@application1.description)
          expect(page).to have_content(@application1.status)
          expect(page).to have_content("Pets")
          expect(page).to have_no_content("Submit")
      end

      it "should allow you to search for and click on a pet" do 
        visit "/applications/#{@applicant1.id}"

        within("#add-a-pet") do
          expect(page).to have_content("Add a Pet!")
          expect(page).to have_button('Search')
          expect(page).to have_content(@pet1.name)
          expect(page).to have_content(@pet2.name)
        end

        @short_pet = @pet1.name.downcase[1..-1]
        within ("#add-a-pet") do
          fill_in "Search", with: @short_pet
          click_on "Search"

          expect(page).to have_content(@pet1.name)
          expect(page).to have_no_content(@pet2.name)
        end

        click_on "#{@pet1.name}"

        expect(current_path).to eq("/pets/#{@pet1.id}")

      end

      it "should allow you to adopt a pet and submit an application" do
        visit "/applications/#{@applicant1.id}"
        
        within("#pet-#{@pet1.id}") do
            expect(page).to have_button('Adopt me!')
            expect(page).to have_content(@pet1.name)
        end

        within("#pet-#{@pet2.id}") do
          expect(page).to have_button('Adopt me!')
          expect(page).to have_content(@pet2.name)

          click_button("Adopt me!")
        end

        expect(current_path).to eq("/applications/#{@application1.id}")

        within("#app-info") do
          expect(page).to have_content(@pet2.name)
        end

        within("#submit") do
          expect(page).to have_content('Description')
        
          click_button('Submit')
      end

        expect(current_path).to eq("/applications/#{@application1.id}")

        within("#app-info") do
          expect(page).to have_content("Status: Pending")
          expect(page).to have_content(@pet2.name)
        end

        within("#add-a-pet") do
          expect(page).to have_no_content("Add a Pet!")
        end
      end
    end
end

