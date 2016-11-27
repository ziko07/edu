class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :user
  belongs_to :course_status
  validates_presence_of :title, :subtitle
  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.published
    where(course_status_id: 2)
  end
  def self.unpublished
    where(course_status_id: 4)
  end
  def self.pending_review
    where(course_status_id: 1)
  end
  def self.rejected
    where(course_status_id: 3)
  end
end
