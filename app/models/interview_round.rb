class InterviewRound < ApplicationRecord
  belongs_to :interview
  belongs_to :employee
  has_many :skill_ratings, dependent: :destroy
  scope :scheduled, -> { where(status: STATUS[:scheduled]) }
  scope :done, -> { where(status: STATUS[:done]) }

  STATUS = {
    scheduled: 1,
    done: 2
  }

  def round_status
    STATUS.fetch(self.status.to_i, "Unknown")
  end

  def rating
    ratings = skill_ratings.pluck(:rating)
    # return 0 if (ratings.nil? or ratings.empty?)
    # (ratings.inject(:+)/ratings.length.to_f).round(1)
  end

  def ratings_as_string
    self.skill_ratings.map { |r| "#{r.skill.skill_name} #{r.rating}/#{SkillRating::MAX_RATING}"}.join(', ')
  end
end
