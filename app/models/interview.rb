class Interview < ApplicationRecord
  belongs_to :candidate, class_name: :Person, foreign_key: :candidate_id
  has_many :interview_rounds, dependent: :destroy
  validates_length_of :interview_rounds, maximum: 3
  accepts_nested_attributes_for :interview_rounds, allow_destroy: true, reject_if: :all_blank

  def status
    status = interview_rounds.select {|r| r.status}.last
    return "Unknown" if status.nil?
    InterviewRound::Status.fetch(status, "Unknown")
  end

  def average_ratings
    # Finds the average ratings for all the rounds
    # Get the ratings from all the rounds and find the average
    # All ratings are out of 5 (assumed)
    # Example:
    # R1 = [2, 3, 4], R2 = [1, 4], R3 = [3, 3]
    # Formulae used:
    # (R1 + R2 + R3)/(total number of ratings).to_f
    # (2 + 3 + 4 + 1 + 4 + 3 + 3)/7.0
    # => 2.9 (rounded to 1 decimal place)
    # Not restricted to only 3 rounds. Could calculate as many rounds rating as are in DB
    all_ratings = interview_rounds.map{|i| i.rating}
    all_ratings.flatten!.compact!
    return 0 if (all_ratings.nil? or all_ratings.empty?)
    (all_ratings.inject(:+)/all_ratings.length.to_f).round(1)
  end


  def self.get_interviews(id=nil, opts={page: 1})
    begin
      if id
        Interview.includes(:candidate, interview_rounds: [:employee, {skill_ratings: :skill}]).where(id: id)
      else
        Interview.includes(:candidate, interview_rounds: :skill_ratings).all
      end
    rescue
      return []
    end
  end

  def self.filter_candidates_by_rating(filter_by)
    return [] unless filter_by

    filter_by.to_s.downcase!
    if filter_by == "rating_3"
      filter_candidates_by_rating_3
      get_interviews(filter_candidates_by_rating_3)
    elsif filter_by == "rating_3_not_2"
      get_interviews(filter_candidates_by_rating_3_no_below_2)
    else
      []
    end
  end

  def self.filter_candidates_by_rating_3
    # find interviews having atleast 3 rounds and having average rating >= 3
    # returns filtered Interview records IDs
    Interview.joins(interview_rounds: :skill_ratings)
      .where("interview_rounds.status = ?", InterviewRound::STATUS[:done])
      .group("interview_rounds.interview_id")
      .having("count(interview_rounds.interview_id) >= ?", 3)
      .having("AVG(skill_ratings.rating) >= ?", 3).pluck(:id)

  end

  def self.filter_candidates_by_rating_3_no_below_2
    # find interviews having atleast 3 rounds and having average rating >= 3
    # returns filtered Interview records IDs
    interview_ids = filter_candidates_by_rating_3

    return [] if interview_ids.empty?

    # find interview rounds having any rating below 2
    interview_round_ids = InterviewRound.joins(:skill_ratings)
                            .where("interview_rounds.interview_id IN (#{interview_ids.join(',')})")
                            .where("skill_ratings.rating < ?", 2).pluck(:id)

    # find interviews having average rating > 3
    # and reject the ones having any rating < 2 in any skill
    Interview.joins(interview_rounds: :skill_ratings)
                          .where("interviews.id IN (#{interview_ids.join(',')})")
                          .where("interviews.id NOT IN (select interview_id from interview_rounds where id IN (#{interview_round_ids.join(',')}))")
                          .pluck(:id)

  end
end
