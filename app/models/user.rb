class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ADMIN_EMAILS = ['nazrulku07@gmail.com', 'admin@example.com']
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
    ADMIN_EMAILS.include?(self.email)
  end

  def pending_course
    Course.joins(:course_status).where("course_statuses.name = '#{AppData::COURSE_STATUS[:pending_review]}'")
  end

  def published_course
    Course.joins(:course_status).where("course_statuses.name = '#{AppData::COURSE_STATUS[:published]}'")
  end

  def unpublished_course
    Course.joins(:course_status).where("course_statuses.name = '#{AppData::COURSE_STATUS[:unpublished]}'")
  end

  def rejected_course
    Course.joins(:course_status).where("course_statuses.name = '#{AppData::COURSE_STATUS[:rejected]}'")
  end

  private

  def user_slug
    name_count = User.where('first_name = ?', first_name).count
    count = (name_count > 0) ? "-" + (name_count + 1).to_s : nil
    "#{first_name}#{count}"
  end
end
