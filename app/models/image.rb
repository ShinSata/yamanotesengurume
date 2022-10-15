class Image < ApplicationRecord
    belongs_to :gurume
    mount_uploader :image, ImageUploader
end
