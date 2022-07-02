class Skill < ApplicationRecord
  validates :skill_name, presence: true, uniqueness: {case_sensitive: false}
  has_and_belongs_to_many :people
end
