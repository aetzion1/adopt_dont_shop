class Application < ApplicationRecord
    belongs_to :applicant
    has_many :adoptions
    has_many :pets, through: :adoptions

    # validates_presence_of :description
    enum status: [:"In Progress", :Pending, :Accepted, :Rejected]

    def all_approved
        adoptions.where(status: true).count == self.adoptions.count
    end

    def not_all_approved
        adoptions.where(status: false).count >= 1
    end

end
