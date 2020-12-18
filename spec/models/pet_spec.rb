require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it {should belong_to :shelter }
    it {should have_many :adoptions}
    it {should have_many(:applications).through(:adoptions)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  before :each do
    @dans = Shelter.create!(name: "Dan's Doghouse", address: "123 Hellhound St", city: "Dogtown", state: "CA", zip: 66666)
    @kathys = Shelter.create!(name: "Kathy's Kathouse", address: "1 Rodeo Drive", city: "Beverly Hills", state: "CA", zip: 90210)
    @stinkys = Shelter.create!(name: "Ms. Stinky's", address: "165 12th St", city: "Boston", state: "MA", zip: 87655)
    
    @dans.pets.create!(name: 'Buck',
        approximate_age: 2,
        description: "big and black, loves peanut butter, hates mailmen", 
        adoptable: true,
        sex: 0)
    @dans.pets.create!(name: 'Princess',
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

    Adoption.create!(pet: @chester, application: @adam.applications.first)
    Adoption.create!(pet: @lil, application: @georgia.applications.first)

  
  end

  describe "class methods" do
    it "can provide avg_age, adoptable_count and adopted_count" do
      expect(Pet.adoptable_count).to eq(6)
      expect(Pet.adopted_count).to eq(0)
      expect(Pet.avg_age.round(1)).to eq(4.2)
    end

    it "can search, can provide pending_apps, and provide action_required" do
    end
  end

end
