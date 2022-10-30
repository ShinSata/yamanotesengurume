class Bookmark < ApplicationRecord
  belongs_to :gurume
  belongs_to :user
  validates_uniqueness_of :gurume_id, scope: :user_id
end
