class Candidate < Person
  validates :name, presence: true, length: {maximum: 16}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_and_belongs_to_many :skills, foreign_key: :person_id
  belongs_to :interviewer, class_name: :Employee, foreign_key: :person_id, optional: true
  has_many :interviews, foreign_key: :candidate_id
end