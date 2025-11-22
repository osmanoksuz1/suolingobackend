class VoiceSample < ApplicationRecord
  belongs_to :profile
  has_one_attached :audio_file

  validates :profile_id, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  # validates :audio_file, presence: true, content_type: ['audio/mpeg', 'audio/wav', 'audio/mp3'], size: { less_than: 10.megabytes }
end
