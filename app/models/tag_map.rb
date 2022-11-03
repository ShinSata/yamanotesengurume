class TagMap < ApplicationRecord
  belongs_to :gurume
  belongs_to :tag
  validates :gurume_id, presence: true
  validates :tag_id, presence: true
end
