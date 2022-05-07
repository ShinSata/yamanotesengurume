class CreateGurumes < ActiveRecord::Migration[6.1]
  def change
    create_table :gurumes do |t|
      t.string :eatry_name
      t.string :genre
      t.text :purpose
      t.integer :price
      t.integer :delicious
      t.string :access
      t.text :others

      t.timestamps
    end
  end
end
