require 'rails_helper'

RSpec.describe 'From Pet Index page, create new Application' do
    before :each do
        @shelter1 = FactoryBot.create(:shelter)
        @pet1 = FactoryBot.create(:pet, shelter: @shelter1)
        @pet2 = FactoryBot.create(:pet, shelter: @shelter1)
      end
    
    describe 'As a visitor, when I visit /pets and click to Start an Application' do
        it "I can start a new application" do
            visit "/pets"

            click_link 'Start an Application'
            
            expect(current_path).to eq('/applications/new')
            expect(page).to have_content("Name")
            expect(page).to have_content("City")
            expect(page).to have_content("State")
            expect(page).to have_content("Zip")

            fill_in 'Name', with: "Adam"
            fill_in 'Address', with: "123 cherry st"
            fill_in 'City', with: "Denver"
            fill_in 'State', with: "CO"
            fill_in 'Zip', with: "80205"
            click_on 'Submit'

            @application = Application.last 

            expect(current_path).to eq("/applications/#{@application.id}")
            
            expect(page).to have_content("Adam")
            expect(page).to have_content("123 cherry st")
            expect(page).to have_content("Denver")
            expect(page).to have_content("CO")
            expect(page).to have_content("80205")
            expect(page).to have_content('In Progress')
        end

        it "Can not start application without completing all fields" do
            visit "/applications/new"
            fill_in 'Name', with: "Adam"
            fill_in 'Address', with: "123 cherry st"

            click_on 'Submit'
            # within ('#new-application') do
            #     expect(page).to have_content("Adam")
            #     expect(page).to have_content("123 cherry st")    
            #     expect(page).to have_button('Submit')
            # end
            within ('#flash-notice') do
                expect(page).to have_content("City can't be blank")
                expect(page).to have_content("State can't be blank")
                expect(page).to have_content("Zip can't be blank")
            end
        end
    end
end 