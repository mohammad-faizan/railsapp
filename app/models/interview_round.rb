class InterviewRound < ApplicationRecord
  belongs_to :interview
  belongs_to :employee
  has_many :skill_ratings

  STATUS = {
    1 => "Scheduled",
    2 => "Done"
  }

  def rating
    ratings = skill_ratings.pluck(:rating)
    return nil if (ratings == nil or ratings.empty?)
    (ratings.inject(:+)/ratings.length.to_f).round(1)
  end
end
