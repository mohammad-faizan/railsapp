require 'rails_helper'

RSpec.describe Interview, type: :model do
  describe 'associations' do
    it { should belong_to :candidate }
    it { should have_many :interview_rounds }
  end

  describe 'validations' do
    it { should accept_nested_attributes_for :interview_rounds }
  end

  describe 'schema' do
    it { should have_db_column(:candidate_id).of_type(:integer) }
    it { should have_db_column(:requirements).of_type(:text) }
  end
end
