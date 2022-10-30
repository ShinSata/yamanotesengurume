class Gurume < ApplicationRecord
    has_many :images
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :bookmarked_users, through: :bookmarks, source: :user
end
