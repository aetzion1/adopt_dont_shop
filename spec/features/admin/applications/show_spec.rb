require 'rails_helper'

RSpec.describe "the admin/application show page" do
    before :each do
        @shelter1 = FactoryBot.create(:shelter)
        @shelter2 = FactoryBot.create(:shelter)
        @pet1 = FactoryBot.create(:pet, shelter: @shelter1)
        @pet2 = FactoryBot.create(:pet, shelter: @shelter1)
        @pet3 = FactoryBot.create(:pet, shelter: @shelter2)
        @applicant1 = FactoryBot.create(:applicant)
        @applicant2 = FactoryBot.create(:applicant)
        @application1 = FactoryBot.create(:application, applicant: @applicant1)
        @application2 = FactoryBot.create(:application, applicant: @applicant2)

        Adoption.create!(pet: @pet1, application: @application1)
        Adoption.create!(pet: @pet2, application: @application1)
        Adoption.create!(pet: @pet1, application: @application2)
        Adoption.create!(pet: @pet3, application: @application2)
    end

    describe "As a visitor" do
        describe "When I visit an admin application show page" do
            it "Displays pets and ability to approve or reject" do
            
                visit "/admin/applications/#{@application1.id}"

                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_content(@pet1.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
                
                within ("#pet-#{@pet2.id}") do
                    expect(page).to have_content(@pet2.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
            
            end

            it "Allows me to approve a pet" do
                visit "/admin/applications/#{@application1.id}"
    
                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end
            
                expect(current_path).to eq("/admin/applications/#{@application1.id}")

                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_content(@pet1.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
                
                within ("#pet-#{@pet2.id}") do
                    expect(page).to have_content(@pet2.name)
                    expect(page).to_not have_button('Approve')
                    expect(page).to_not have_button('Reject')
                    expect(page).to have_content('Approved')
                end

            end

            it "Allows me to reject a pet" do
                visit "/admin/applications/#{@application1.id}"

                within ("#pet-#{@pet2.id}") do
                    click_button 'Reject'
                end
            
                expect(current_path).to eq("/admin/applications/#{@application1.id}")

                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_content(@pet1.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
                
                within ("#pet-#{@pet2.id}") do
                    expect(page).to have_content(@pet2.name)
                    expect(page).to_not have_button('Approve')
                    expect(page).to_not have_button('Reject')
                    expect(page).to have_content('Rejected')
                end

            end

            it "Approval does not impact other applciations" do
                visit "/admin/applications/#{@application1.id}"

                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end

                visit "/admin/applications/#{@application2.id}"

                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_content(@pet1.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
                
                within ("#pet-#{@pet3.id}") do
                    expect(page).to have_content(@pet3.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
            
            end

            it "Rejection does not impact other applications" do
                visit "/admin/applications/#{@application1.id}"

                within ("#pet-#{@pet2.id}") do
                    click_button 'Reject'
                end

                visit "/admin/applications/#{@application2.id}"

                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_content(@pet1.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
                
                within ("#pet-#{@pet3.id}") do
                    expect(page).to have_content(@pet3.name)
                    expect(page).to have_button('Approve')
                    expect(page).to have_button('Reject')
                end
            end

        end

        describe "When I approve all pets on an application" do
            it "Application's status is Approved on show page" do
                visit "/admin/applications/#{@application1.id}"
                
                within ("#pet-#{@pet1.id}") do
                    click_button 'Approve'
                end

                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end

                expect(page).to have_content("Status: Accepted")
            end

            it "changes all pet show pages to no longer adoptable" do
                visit "/admin/applications/#{@application1.id}"
                
                within ("#pet-#{@pet1.id}") do
                    click_button 'Approve'
                end

                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end

                visit "/pets/#{@pet1.id}"
                expect(page).to have_content("Adopted!")
                
                visit "/pets/#{@pet2.id}"
                expect(page).to have_content("Adopted!")
            
            end

            it "for pending applications with approved pets - no approve button, reject button and message displayed" do
                visit "/admin/applications/#{@application1.id}"
                
                within ("#pet-#{@pet1.id}") do
                    click_button 'Approve'
                end

                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end

                visit "/admin/applications/#{@application2.id}"
                
                within ("#pet-#{@pet1.id}") do
                    expect(page).to have_button("Reject")
                    expect(page).to have_no_button("Accept")
                    expect(page).to have_content("This pet has been approved for adoption")
                end
            
            end
        end


        describe "When I reject one or more pets on an application" do
            it "Application's status is displayed as Rejected on show page" do
                visit "/admin/applications/#{@application1.id}"
                
                within ("#pet-#{@pet1.id}") do
                    click_button 'Reject'
                end

                expect(page).to have_content("Status: Rejected")

                within ("#pet-#{@pet2.id}") do
                    click_button 'Approve'
                end

                expect(page).to have_content("Status: Rejected")
            
            end
        
        end
    end
end