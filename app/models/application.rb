class Application < ApplicationRecord
    belongs_to :applicant
    has_many :adoptions
    has_many :pets, through: :adoptions

    # validates_presence_of :description
    enum status: [:"In Progress", :Pending, :Accepted, :Rejected]

    def all_approved
        binding.pry
        if self.adoptions.where(status: true).count == self.adoptions.count
            true
        else
            false
        end
    end

    def not_all_approved
        if self.adoptions.where(status: false).count >= 1
            true
        else
            false
        end
    end

end
