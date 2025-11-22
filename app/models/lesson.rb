class Lesson < ApplicationRecord
  belongs_to :profile
  has_many :videos, dependent: :destroy

  validates :profile_id, presence: true
  validates :lesson_text, presence: true, length: { minimum: 10 }
  validates :difficulty_level, presence: true, inclusion: { in: %w[beginner intermediate advanced] }
end
