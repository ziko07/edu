class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :user
  belongs_to :course_status
  validates_presence_of :title, :subtitle
  extend FriendlyId
  friendly_id :course_slug, use: :slugged

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

  private

  def course_slug
    title_count = Course.where('title = ?', title).count
    count = (title_count > 0) ? '-' + (title_count + 1).to_s : nil
    "#{title.gsub(' ', '-')}#{count}"
  end

  def self.category_courses
    published_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:published])
    if published_status.present?
      @group_courses = Category.joins(:courses).where("courses.course_status_id = #{published_status.id}")
    else
      @group_courses = Category.joins(:courses)
    end
  end

end
