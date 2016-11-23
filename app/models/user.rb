class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  extend FriendlyId
  friendly_id :user_slug, use: :slugged


  private

  def user_slug
    slg = self.first_name
    if self.last_name.present?
      slg += self.last_name.chars.first
    end
    slg
  end
end
