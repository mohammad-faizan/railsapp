class Employee < Person
  validates :name, presence: true, length: {minimum: 5}, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_and_belongs_to_many :skills, foreign_key: :person_id
  has_many :candidates, class_name: :Person, foreign_key: :person_id
  has_many :interviews, through: :interview_rounds, foreign_key: :employee_id
end