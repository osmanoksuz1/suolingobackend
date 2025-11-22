class Video < ApplicationRecord
  belongs_to :profile
  belongs_to :lesson
  belongs_to :voice_sample

  validates :profile_id, :lesson_id, :voice_sample_id, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending processing completed failed] }
end
