require 'rails_helper'

RSpec.describe SkillRating, type: :model do
  describe 'associations' do
    it { should belong_to :interview_round }
    it { should belong_to :skill }
  end

  describe 'validations' do
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end

  describe 'schema' do
    it { should have_db_column(:interview_round_id).of_type(:integer) }
    it { should have_db_column(:skill_id).of_type(:integer) }
    it { should have_db_column(:rating).of_type(:integer) }
  end
end
