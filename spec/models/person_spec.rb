require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many :skills}
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe Employee, type: :model do
    describe 'associations' do
      it { should have_many(:candidates).class_name(:Person) }
      it { should have_many(:interview_rounds) }
      it { should have_many(:interviews).through(:interview_rounds) }
    end

    describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_length_of(:name).is_at_least(5) }
    end
  end

  describe Candidate, type: :model do
    describe 'associations' do
      it { should have_many :interviews}
    end

    describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_length_of(:name).is_at_most(16) }
    end
  end

  describe 'schema' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:dob).of_type(:date) }
    it { should have_db_column(:experience).of_type(:integer) }
    it { should have_db_column(:type).of_type(:string) }
    it { should have_db_column(:person_id).of_type(:integer) }
  end
end
