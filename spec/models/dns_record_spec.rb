require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  describe 'columns validations' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:ip).of_type(:string).with_options(null: false, limit: 15) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'relationships validations' do
    it { is_expected.to have_many(:hostnames) }
  end

  describe 'index validations' do
    it { is_expected.to have_db_index(:ip).unique(true) }
  end

  describe 'fields validations' do
    it { is_expected.to validate_presence_of(:ip) }
    it { is_expected.to validate_length_of(:ip).is_at_most(15) }
  end
end