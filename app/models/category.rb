class Category < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ImageUploader
  friendly_id :title, use: :slugged
  has_many :courses
end
