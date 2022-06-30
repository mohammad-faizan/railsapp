require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:dob).of_type(:date) }
  it { is_expected.to have_db_column(:experience).of_type(:number) }
  it { is_expected.to have_db_column(:type).of_type(:string) }
end
