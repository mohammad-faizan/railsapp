class Candidate < Person
  validates :name, presence: true, length: {maximum: 16}

  # belongs_to :interviewer, class_name: :Employee, foreign_key: :person_id, optional: true
  has_many :interviews, foreign_key: :candidate_id
end