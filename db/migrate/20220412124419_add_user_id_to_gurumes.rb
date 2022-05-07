class AddUserIdToGurumes < ActiveRecord::Migration[6.1]
  def change
    add_column :gurumes, :user_id, :integer
  end
end
