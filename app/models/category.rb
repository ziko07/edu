class Category < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :image, ImageUploader
  friendly_id :title, use: :slugged
  has_many :courses

  def published_courses
    courses.joins(:course_status).where("course_statuses.name = '#{AppData::COURSE_STATUS[:published]}'")
  end

end
