class Profile < ApplicationRecord
  has_one_attached :profile_photo
  has_many :voice_samples, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :videos, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :profile_photo, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
end
