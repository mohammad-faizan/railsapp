# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
skills.each do |skill|
  Skill.create(skill_name: skill)
end

(1..10).each do |n|
  t = "Employee_#{n}"
  d = lambda {|t| {name: t,email: "#{t}@email.com",experience: rand(1..15)}}
  emp = Employee.create(d.call(t))
  t = "Candidate_#{n}"
  cand = Candidate.create(d.call(t))
  p PeopleSkill.create(person_id: emp.id, skill_id: n)
  p PeopleSkill.create(person_id: cand.id, skill_id: n)
  intrvw = Interview.create(candidate: cand, requirements: skills.sample(rand(1..skills.length)).join(' '))
  (1..3).each do |o|
    ir = InterviewRound.create(interview: intrvw, employee: emp, when: DateTime.now, where: "Some place", review_comments: "Text review comments")
    (1..rand(10)).each do |k|
      SkillRating.create(interview_round: ir, skill_id: k, rating: rand(1..5))
    end
  end
end