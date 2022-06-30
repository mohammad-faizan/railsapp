class Interview < ApplicationRecord
  belongs_to :candidate, class_name: :Person, foreign_key: :candidate_id
  has_many :interview_rounds, dependent: :destroy
  validates_length_of :interview_rounds, maximum: 3
  accepts_nested_attributes_for :interview_rounds, allow_destroy: true, reject_if: :all_blank, allow_destroy: true

  def status
    status = interview_rounds.select {|r| r.status}.last
    return "Unknown" if status.nil?
    InterviewRound::Status.fetch(status, "Unknown")
  end

  def average_ratings
    all_ratings = interview_rounds.map{|i| i.rating}
    all_ratings.compact!
    return 0 if (all_ratings.nil? or all_ratings.empty?)
    (all_ratings.inject(:+)/all_ratings.length.to_f).round(1)
  end

  def self.filter(min_rating, avg_rating)
    # find interviews having atleast 3 rounds
    interviews = Interview.joins(:interview_rounds).group("interviews.id").having("count(interview_rounds.id) >= ?", 3).pluck(:id)

    # Find associated interview rounds
    interview_rounds = InterviewRound.where(interview_id: interviews).pluck(:id)

    # Find skill ratings
    rounds_rating_below_2 = SkillRating.where(interview_round_id: interview_rounds)
                                      .where('rating < ?', min_rating)
                                      .pluck(:interview_round_id)

    eligible_rounds = (interview_rounds - rounds_rating_below_2.uniq)

    final_result = Interview.includes(interview_rounds: :skill_ratings).joins(interview_rounds: :skill_ratings)
                            .where("interview_rounds.id IN (#{eligible_rounds.join(',')})")

    # filter and return interviews having average >= 3
    final_result.select {|i| i.average_ratings >= 3}
  end
end
