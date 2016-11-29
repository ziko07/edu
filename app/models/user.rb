class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses
  extend FriendlyId
  friendly_id :user_slug, use: :slugged


  private

  def user_slug
    name_count = User.where('first_name = ?', first_name).count
    count = (name_count > 0) ? "-" + (name_count + 1).to_s : nil
    "#{first_name}#{count}"
  end
end
