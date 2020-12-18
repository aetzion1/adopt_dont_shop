class Shelter < ApplicationRecord
  has_many :pets

  def self.sort_by_name_desc
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    # order(name: :desc)
  end
end
