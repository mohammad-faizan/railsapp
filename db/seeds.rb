# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
skills = [
  'Ruby',
  'Rails',
  'MySql',
  'SQLite',
  'Oracle',
  'Java',
  'JavaScript',
  'NodeJS',
  'Python',
  'GoLang',
  'Postgres',
  'JQuery',
  'HTML5',
  'Microservices',
  'AWS',
  'Azure',
  '.Net',
  'Django',
  'AngularJS',
  'Big Data',
  'Machine Learning',
  'Data Science'
]

created_skills = []
skills.each do |skill|
  created_skills << Skill.create(skill_name: skill)
end

(1..100).each do |n|
  d = lambda {|t| {name: t,email: "#{t}@email.com",experience: rand(1..15)}}

  # Type Employee
  t = "Employee_#{n}"
  emp = Employee.create(d.call(t))

  # Type Candidate
  t = "Candidate_#{n}"
  candidate_data = d.call(t)
  candidate_data[:dob] = Date.today
  cand = Candidate.create(candidate_data)

  sampled_skills = created_skills.sample(rand(5..22))
  sampled_skills.each do |skill|
    PeopleSkill.create(person: emp, skill: skill)
    PeopleSkill.create(person: cand, skill: skill)
  end

  interview = Interview.create(candidate: cand, requirements: "Skill requirements - #{n}")

  (1..3).each do |round|
    interview_round = InterviewRound.create(interview: interview,
                        employee: emp, when: DateTime.now,
                        where: "Interview Place #{n} - #{round}",
                        review_comments: "review comments #{n} - #{round}",
                        status: InterviewRound::STATUS[:done])

    sampled_skills.each do |skill|
      rating = n.even? ? rand(1..5) : rand(2..5)
      SkillRating.create(interview_round: interview_round, skill: skill, rating: rating)
    end
  end
end