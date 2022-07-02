require 'rails_helper'

RSpec.describe InterviewRound, type: :model do
  describe 'associations' do
    it { should belong_to :interview }
    it { should belong_to :employee }
    it { should have_many :skill_ratings }
  end

  describe 'schema' do
    it { should have_db_column(:interview_id).of_type(:integer) }
    it { should have_db_column(:employee_id).of_type(:integer) }
    it { should have_db_column(:when).of_type(:datetime) }
    it { should have_db_column(:where).of_type(:string) }
    it { should have_db_column(:review_comments).of_type(:text) }
    it { should have_db_column(:status).of_type(:string) }
  end
end
