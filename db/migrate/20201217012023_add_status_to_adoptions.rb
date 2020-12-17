class AddStatusToAdoptions < ActiveRecord::Migration[5.2]
  def change
    add_column :adoptions, :status, :boolean
  end
end