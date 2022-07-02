require 'rails_helper'

RSpec.describe PeopleSkill, type: :model do
  describe 'associations' do
    it { should belong_to :person }
    it { should belong_to :skill }
  end

  describe 'schema' do
    it { should have_db_column(:person_id).of_type(:integer) }
    it { should have_db_column(:skill_id).of_type(:integer) }
  end
end
