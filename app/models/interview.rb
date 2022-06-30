class Interview < ApplicationRecord
  belongs_to :candidate, class_name: :Person, foreign_key: :candidate_id
  has_many :interview_rounds
  validates_length_of :interview_rounds, maximum: 3
  accepts_nested_attributes_for :interview_rounds, allow_destroy: true, reject_if: :all_blank

  def status
    "sac" #interview_rounds.last.status
  end

  def average_ratings
    all_ratings = interview_rounds.map{|i| i.rating}
    all_ratings.compact!
    return 0 if (all_ratings == nil or all_ratings.empty?)
    (all_ratings.inject(:+)/all_ratings.length.to_f).round(1)
  end
end
