require 'rails_helper'

RSpec.describe 'Pets index page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
  end

  describe "As a visitor, when I visit /pets" do
    it "displays each pet in the system with attributes" do

      visit "/pets"

      expect(page).to have_content(@pet1.image)
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet1.approximate_age)
      expect(page).to have_content(@pet1.sex)
      expect(page).to have_content(@shelter1.name)

      expect(page).to have_content(@pet2.image)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_content(@pet2.approximate_age)
      expect(page).to have_content(@pet2.sex)
      expect(page).to have_content(@shelter2.name)

      expect(page).to_not have_content(@shelter3.name)
    end

    it "can delete a pet from pet index page" do
      visit "/pets"

      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("Thor")
        click_link "Delete Pet"
      end

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content("Thor")
    end

    it "can edit a pet from pets index page" do
      visit '/pets'

      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("Thor")
        click_link "Update Pet"
      end

      fill_in "name", with: "Calvin"

      click_button "Update Pet"

      expect(current_path).to eq("/pets/#{@pet1.id}")

      expect(page).to have_content("Calvin")
      expect(page).to_not have_content("Thor")
    end

    it "Has start an application link that redirects to new applciation page" do 
      visit '/pets'

      click_link "Start an Application"
      
      expect(current_path).to eq('/applications/new')
    end
  end
  
end
