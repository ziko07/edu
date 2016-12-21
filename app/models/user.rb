class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ADMIN_EMAILS = ['nazrulku07@gmail.com', 'sam-yoong@hotmail.com', 'zikoku07@gmail.com']
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses
  extend FriendlyId
  friendly_id :user_slug, use: :slugged
  validate :email_uniqueness

  def email_uniqueness
    if self.errors.key?(:email) && User.where(:email => self.email).exists?
      self.errors.delete(:email)
      self.errors.add(:custom, 'Sorry, another user has registered with this email address. Please use another email to register')
    end
  end

  def is_admin?
     self.is_admin
  end

  def pending_course
    pending_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:pending_review])
    if pending_status.present?
      Course.joins(:user).where('course_status_id = ? and users.published = true', pending_status.id)
    else
      []
    end
  end

  def published_course
    published_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:published])
    if published_status.present?
      Course.joins(:user).where('course_status_id = ? and users.published = true', published_status.id)
    else
      []
    end
  end

  def unpublished_course
    unpublished_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:unpublished])
    if unpublished_status.present?
      Course.joins(:user).where('course_status_id = ? and users.published = true', unpublished_status.id)
    else
      []
    end
  end

  def rejected_course
    rejected_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:rejected])
    if rejected_status.present?
      Course.joins(:user).where('course_status_id = ? and users.published = true', rejected_status.id)
    else
      []
    end
  end

  def self.admin_course_status
    CourseStatus.where("name != '#{AppData::COURSE_STATUS[:pending_review]}'")
  end

  # Unpublished courses after an instructor unpublished
  def unpublish_courses
    unpublish_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:unpublished])
    user_courses = courses.joins(:course_status).where('course_statuses.name = ?', AppData::COURSE_STATUS[:published])
    user_courses.each do |course|
      course.update_attribute(:course_status_id, unpublish_status.id)
    end
  end

  # Published courses after an instructor published
  def publish_courses
    publish_status = CourseStatus.find_by_name(AppData::COURSE_STATUS[:published])
    user_courses = courses.joins(:course_status).where('course_statuses.name = ?', AppData::COURSE_STATUS[:unpublished])
    user_courses.each do |course|
      course.update_attribute(:course_status_id, publish_status.id)
    end
  end

  def name
    if full_name.present?
      full_name
    else
      ins_name = first_name
      if last_name.present?
        ins_name += ' ' + last_name
      end
      ins_name
    end
  end

  private

  def user_slug
    name_count = User.where('first_name = ?', first_name).count
    count = (name_count > 0) ? "-" + (name_count + 1).to_s : nil
    "#{first_name}#{count}"
  end
end
