class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :category
  belongs_to :user
  validates_presence_of :title, :subtitle

end
