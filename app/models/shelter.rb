class Shelter < ApplicationRecord
  has_many :pets

  def self.sort_by_name_desc
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    # order(name: :desc)
  end

  def self.sort_by_name_asc
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name asc")
    # order(name: :desc)
  end

  def self.find_by(id)
    find_by_sql("SELECT * FROM shelters WHERE shelters.id = #{id}")
  end

  def pending_apps?
    !pets.pending_apps.empty?
  end

end