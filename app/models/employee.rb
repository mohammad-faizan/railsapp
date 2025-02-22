class Employee < Person
  validates :name, presence: true, length: {minimum: 5}

  has_many :candidates, class_name: :Person, foreign_key: :person_id
  has_many :interview_rounds
  has_many :interviews, through: :interview_rounds, foreign_key: :employee_id
end