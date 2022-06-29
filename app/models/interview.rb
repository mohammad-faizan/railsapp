class Interview < ApplicationRecord
  belongs_to :candidate, class_name: :Person, foreign_key: :candidate_id
  has_many :interview_rounds
  validates_length_of :interview_rounds, maximum: 3
end
