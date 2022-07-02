class SkillRating < ApplicationRecord
  belongs_to :interview_round
  belongs_to :skill
  validates :rating, numericality: { only_integer: true, less_than_or_equal_to: 5 }

  MAX_RATING = 5
end
