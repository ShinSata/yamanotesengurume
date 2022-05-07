class AddImageToGurumes < ActiveRecord::Migration[6.1]
  def change
    add_column :gurumes, :image, :string
  end
end
