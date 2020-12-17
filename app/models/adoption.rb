class Adoption < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  # scope :accepted -> { where(status: true)}
  # scope :rejected -> { where(status: false)}
end
