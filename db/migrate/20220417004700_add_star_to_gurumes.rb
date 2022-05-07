class AddStarToGurumes < ActiveRecord::Migration[6.1]
  def change
    add_column :gurumes, :star, :integer
  end
end
