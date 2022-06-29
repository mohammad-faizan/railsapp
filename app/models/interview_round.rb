class InterviewRound < ApplicationRecord
  belongs_to :interview
  belongs_to :employee
  has_many :skill_ratings
end
