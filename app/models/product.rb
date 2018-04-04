class Product < ApplicationRecord
  mount_uploader :photo, PhotoUploader
end
