class SkillRating < ApplicationRecord
  belongs_to :interview_round
  belongs_to :skill
end
