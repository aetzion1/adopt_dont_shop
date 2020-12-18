class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :adoptions
  has_many :applications, through: :adoptions

  def self.search(search)
    if search
      pet = Pet.where("LOWER(name) LIKE ?", "%#{search.downcase}%")
      # pet = Pet.find_by(name: search.titlecase)
      if pet
        pet
      else
        Pet.all
      end
    else
      Pet.all
    end
  end

  def self.pending_apps
    select("DISTINCT ON (pets.name) pets.name, applications.id as app_id")
    .joins(adoptions: [:application])
  end

  validates_presence_of :name, :description, :approximate_age, :sex
  # ^ AR method to validate presence of column
  # note image and adopable is not validated
  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }
  # ^ AR method to validate attribute has numeric value
  enum sex: [:female, :male]
  # ^ AR method to limit to specific enumeration (options)

end
