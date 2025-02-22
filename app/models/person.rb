class Person < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_and_belongs_to_many :skills

  def skills_as_string
  	skills.map{|s| s.skill_name}.join(', ')
  end
end
