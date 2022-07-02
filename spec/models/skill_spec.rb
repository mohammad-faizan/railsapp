require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many :people}
  end

  describe 'validations' do
    it { should validate_presence_of :skill_name }
    it { should validate_uniqueness_of(:skill_name).ignoring_case_sensitivity }
  end

  describe 'schema' do
    it { should have_db_column(:skill_name).of_type(:string) }
  end
end
