class Tag < ApplicationRecord
    has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
    has_many :gurumes, through: :tag_maps
end
