class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.references :gurume
      t.string :image

      t.timestamps
    end
  end
end
