class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :user
  belongs_to :course_status
  validates_presence_of :title, :subtitle
  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.published
    joins(:course_status).where("course_statuses.name like '%published%'")
  end

  def self.unpublished
    joins(:course_status).where("course_statuses.name like '%unpublished%'")
  end

  def self.pending_review
    joins(:course_status).where("course_statuses.name like '%pending review%'")
  end

  def self.rejected
    joins(:course_status).where("course_statuses.name like '%rejected%'")
  end
end
